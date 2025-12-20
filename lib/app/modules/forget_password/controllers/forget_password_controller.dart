import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../../constants/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/api_service.dart';

class ForgetPasswordController extends GetxController {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;
  final count = 0.obs;

  Future<void> submit(void Function() onSuccess) async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      try {
        isSubmitting.value = true;
        final mobile = phoneController.text.trim();
        Get.context?.loaderOverlay.show();
        final api = Get.find<ApiService>();
        final res = await api.post(Endpoints.requestResetOtp, data: {
          'mobile': mobile,
        });
        Get.context?.loaderOverlay.hide();
        isSubmitting.value = false;
        final data = res.data;
        if (data is Map && (data['status'] == true || data['code'] == 200)||res.statusCode == HttpStatus.ok) {
          Notify.success(data['message']?.toString() ?? 'OTP sent');
          // Navigate to OTP screen with identifier
          Get.toNamed(Routes.OTP_VERIFICATION, arguments: {'mobile': mobile});
        } else {
          Notify.error(data is Map ? (data['message']?.toString() ?? 'Failed to send OTP') : 'Failed to send OTP');
        }
      } catch (e) {
        Get.context?.loaderOverlay.hide();
        isSubmitting.value = false;
        Notify.error(e.toString());
      }
    }
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
