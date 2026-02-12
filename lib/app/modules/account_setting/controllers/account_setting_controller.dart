import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../login/repository/auth_service.dart';

class AccountSettingController extends GetxController {
  final newpasswordController = TextEditingController();
  final confirmNewpasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  void submit() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      if (newpasswordController.text != confirmNewpasswordController.text) {
        Notify.error('كلمات المرور غير متطابقة');
        return;
      }
      isSubmitting.value = true;
      _submitChangePassword();
    }
  }

  Future<void> _submitChangePassword() async {
    try {
      final newPass = newpasswordController.text.trim();
      final confirm = confirmNewpasswordController.text.trim();
      final current = currentPasswordController.text.trim();

      Get.context?.loaderOverlay.show();
      dynamic res;
      final auth = Get.find<AuthService>();
      res = await auth.changePassword(
        currentPassword: current,
        newPassword: newPass,
        newPasswordConfirmation: confirm,
      );

      Get.context?.loaderOverlay.hide();
      isSubmitting.value = false;

      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        Notify.success(data['message']?.toString() ?? 'Password changed');

      } else {
        Notify.error(
          data is Map
              ? (data['message']?.toString() ?? 'Change failed')
              : 'Change failed',
        );
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      isSubmitting.value = false;
      Notify.error(e.toString());
    }
  }
  @override
  void onClose() {
    // dispose text controllers to avoid memory leaks
    try {
      newpasswordController.dispose();
    } catch (_) {}
    try {
      confirmNewpasswordController.dispose();
    } catch (_) {}
    try {
      currentPasswordController.dispose();
    } catch (_) {}
    super.onClose();
  }
}
