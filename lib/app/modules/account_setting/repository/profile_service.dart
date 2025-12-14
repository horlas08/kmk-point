import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:path/path.dart' as p;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class ProfileService extends GetxService {
  Future<ProfileService> init() async {
    return this;
  }

  /// Update profile with multipart/form-data because it may include an image file.
  ///
  /// body keys:
  /// - first_name, last_name, email, civil_number, phone, image (file)
  Future<Response> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String civilNumber,
    required String phone,
    File? image,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    final api = Get.find<ApiService>();

    final Map<String, dynamic> formMap = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'civil_number': civilNumber,
      'phone': phone,
    };

    if (image != null) {
      final fileName = p.basename(image.path);
      formMap['image'] = await MultipartFile.fromFile(image.path, filename: fileName);
    }

    final formData = FormData.fromMap(formMap);

    return api.post(
      Endpoints.updateProfile,
      data: formData,
      onSendProgress: onSendProgress,
    );
  }
}
