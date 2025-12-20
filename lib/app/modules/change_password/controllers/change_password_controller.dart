import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../login/repository/auth_service.dart';
import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class ChangePasswordController extends GetxController {
  final newpasswordController = TextEditingController();
  final confirmNewpasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;
  String? resetToken;

  void submit(void Function() onSuccess) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      if (newpasswordController.text != confirmNewpasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }
      isSubmitting.value = true;
      _submitChangePassword(onSuccess);
    }
  }

  Future<void> _submitChangePassword(void Function() onSuccess) async {
    try {
  final newPass = newpasswordController.text.trim();
  final confirm = confirmNewpasswordController.text.trim();
  final current = currentPasswordController.text.trim();

      Get.context?.loaderOverlay.show();
      dynamic res;
      if ((resetToken ?? '').isNotEmpty) {
        // Reset-password via reset_token
        final api = Get.find<ApiService>();
        res = await api.post(Endpoints.resetPassword, data: {
          'password': newPass,
          'password_confirmation': confirm,
          'reset_token': resetToken,
        });
      } else {
        // Logged-in change password flow
        final auth = Get.find<AuthService>();
        res = await auth.changePassword(
          currentPassword: current,
          newPassword: newPass,
          newPasswordConfirmation: confirm,
        );
      }

      Get.context?.loaderOverlay.hide();
      isSubmitting.value = false;

      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        Notify.success(data['message']?.toString() ?? 'Password changed');
        onSuccess();
      } else {
        Notify.error(data is Map ? (data['message']?.toString() ?? 'Change failed') : 'Change failed');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      isSubmitting.value = false;
      Notify.error(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    resetToken = Get.arguments?['reset_token']?.toString();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
