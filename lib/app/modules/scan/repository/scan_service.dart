import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class ScanService extends GetxService {
  Future<ScanService> init() async {
    return this;
  }

  /// Send QR Code payload to backend
  /// Body: { qrCode, project_id }
  Future<Response> scanQr({
    required String qrCode,
    required String projectId,
  }) async {
    final api = Get.find<ApiService>();
    return await api.post(
      Endpoints.qrCode,
      data: {
        'qrCode': qrCode,
        'project_id': projectId,
      },
    );
  }
}
