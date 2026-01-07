import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_ce/hive.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common/exception/api_exception.dart';
import '../../constants/environment.dart';
import '../../routes/app_pages.dart';


class ApiService {
  static final ApiService _instance = ApiService._internal(Dio());

  factory ApiService() => _instance;

  final Dio _dio;
  String? _accessToken;
  final List<Function(Object?)> _refreshQueue = [];

  ApiService._internal(this._dio) {
    _dio
      ..options.baseUrl = AppEnvironment.baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.validateStatus = (status) {
        // Do not throw for 4xx; let UI handle validation errors gracefully.
        // Only treat 500+ as transport-level errors.
        return status != null && status < 600;
      }

      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Platform': Platform.operatingSystem,
        'Version': Platform.version,
        'Device-manufacturer': "${Hive.box("appData").get("deviceManufacture")}",
        'Accept-Language': 'ar',
        'fcmToken': "${Hive.box("appData").get("fcmToken")?? "no_data"}"
      };
    _initializeService();
  }

  Future<void> _initializeService() async {
    await loadTokens();
    _setupInterceptors();
  }

  // Load tokens from SharedPreferences
  Future<Map<String, dynamic>?> loadTokens() async {
    final accessToken = Hive.box('auth');
    _accessToken = accessToken.get("accessToken");

    if (_accessToken != null) {
      return {'accessToken': _accessToken};
    }
    return null;
  }

  void _setupInterceptors() {
    // Add interceptor for logging and custom handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => _handleRequest(options, handler),
        // onResponse: (response, handler) => _handleResponse(response, handler),
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          // No Internet (from your connectivity check)
          if (error.error is ApiException) {
            handler.reject(error);
            return;
          }
          if (status == 401) {
            try {
              await clearTokens();
            } catch (_) {}
            // Navigate to login on unauthorized
            Get.offAllNamed(Routes.LOGIN);
            handler.reject(error);
            return;
          }
          handler.next(error);
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true, //kDebugMode,
        filter: (options, args) {
          // // don't print requests with uris containing '/posts'
          // if(options.path.contains('/posts')){
          //   return false;
          // }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
    // _dio.interceptors.add(element)
  }

  // Save tokens to SharedPreferences
  Future<void> _saveTokens() async {
    if(_accessToken != null){
      final box =  await Hive.openBox('auth');

      box.put('accessToken', _accessToken!);
    }


  }

  // Clear tokens from SharedPreferences
  Future<void> _clearTokens() async {
    final box = Hive.box('auth');
    box.delete('accessToken');
    box.delete('selectedProjectId');
    box.delete('selectedOrgId');
    box.delete('selectedProjectName');
    _accessToken = null;
  }

  // Handle outgoing requests
  Future<void> _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      // No connection (no network interfaces are up)
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet Connection',
          type: DioExceptionType.connectionError,
        ),
      );
      return;
    }

    // connectivity_plus can report a network interface (wifi/mobile) even when
    // there's no actual Internet access. Do a lightweight DNS lookup to ensure
    // we actually have internet connectivity before allowing the request to proceed.
    try {
      final lookup = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 2));
      if (lookup.isEmpty || lookup.first.rawAddress.isEmpty) {
        handler.reject(
          DioException(
              requestOptions: options,
              error: 'No Internet Connection',
              type: DioExceptionType.connectionError,
            ),
        );
        return;
      }
    } catch (e) {
      // Treat any error during lookup as no connectivity
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet Connection',
          type: DioExceptionType.connectionError,
        ),
      );
      return;
    }
    final token = await loadTokens();

    if (_accessToken != null) {
      options.headers['Authorization'] = 'Bearer $_accessToken';
    }
    print("${options.method} ${options.uri} with $_accessToken");
    handler.next(options);
  }

  // Handle responses
  void _handleResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  /*  // Handle errors
  Future<void> _handleError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 403 ||
        err.response?.statusCode == 419) {
      try {
        await _handleTokenRefresh(err, handler);
      } catch (refreshError) {
        // If token refresh fails, handle logout and reject the error
        appLog('Authentication failed completely, logging user out');
        await _handleAuthFailure();
        handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  } */

  // Handle auth failure by logging user out
  Future<void> _handleAuthFailure() async {
    await clearTokens();
    // User.logout();
  }

  // Queue refresh handling
  Future<void> _queueRefresh() async {
    print('Queuing refresh...');
    final completer = Completer();
    _refreshQueue.add((error) {
      if (error != null) {
        completer.completeError(error);
      } else {
        completer.complete();
      }
    });
    return completer.future;
  }

  // Process queued requests
  void _processQueue(Object? error) {
    for (final request in _refreshQueue) {
      request(error);
    }
    _refreshQueue.clear();
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    print('GET $path with $_accessToken');
    return _dio.get(path, queryParameters: queryParameters, data: data);
  }

  /// Update the FCM token used in request headers and persist it to Hive.
  Future<void> updateFcmToken(String? token) async {
    try {
      final box = Hive.box('appData');
      if (token != null && token.isNotEmpty) {
        box.put('fcmToken', token);
        _dio.options.headers['fcmToken'] = token;
      } else {
        box.put('fcmToken', 'no_data');
        _dio.options.headers['fcmToken'] = 'no_data';
      }
    } catch (e) {
      // ignore
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    print('POST $path with $_accessToken ${_dio.options.baseUrl}$path');
    return _dio.post(
      path,
      data: data,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
  }

  Future<Response> put(String path, {dynamic data}) async {
    print('PUT $path with $_accessToken');
    return _dio.put(path, data: data);
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    print('PATCH $path with $_accessToken');
    return _dio.patch(
      path,
      data: data,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  Future<Response> delete(String path, {dynamic data}) async {
    print('DELETE $path with $_accessToken');
    return _dio.delete(path, data: data);
  }

  // Public methods to manage tokens
  Future<void> setTokens({required String accessToken}) async {
    _accessToken = accessToken;
    await _saveTokens();
  }

  Future<void> clearTokens() async {
    await _clearTokens();
  }
}
