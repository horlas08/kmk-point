import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:get/get.dart' hide Response;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/constants/endpoint.dart';
import 'package:point_system/app/models/auth_data.dart';
import 'package:point_system/app/services/api/api_service.dart';

class AuthService extends GetxService{
  final loginData = Rxn<AuthData>();
  Future init() async {
    //TODO any task
    return this;
  }

  Future<Response> login({required String identifier, required String password}) async {

    final apiServices = Get.find<ApiService>();
    
    return await apiServices.post(Endpoints.login, data: {
      "password": password,
      "identifier": identifier
    });

  }
}