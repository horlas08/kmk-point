import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_ce/hive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/constants/endpoint.dart';
import 'package:point_system/app/models/auth_data.dart';
import 'package:point_system/app/services/api/api_service.dart';

import '../../../models/student.dart' show Student;

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

  /// Change the logged-in participant's password.
  /// Body: { current_password, new_password, new_password_confirmation }
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final apiServices = Get.find<ApiService>();
    return await apiServices.post(Endpoints.changePassword, data: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });
  }

  /// Fetch the current user's data and update loginData
  Future<void> fetchUser() async {
    final apiServices = Get.find<ApiService>();
    final res = await apiServices.get(Endpoints.getUser);
    final data = res.data;
    if (data is Map && (data['status'] == true || data['code'] == 200)) {
      final token = loginData.value?.token;
      loginData.value = AuthData.fromJson(res.data['data']).copyWith(token: token);
      // final studentData = data['data'];
      // if (studentData is Map && loginData.value != null) {
      //   final student = Student.fromJson(studentData as Map<String, dynamic>);
      //   loginData.value = loginData.value!.copyWith(student: student);
        loginData.refresh(); // To notify listeners
      }

  }
}