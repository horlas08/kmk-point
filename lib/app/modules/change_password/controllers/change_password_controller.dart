import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final newpasswordController = TextEditingController();
  final confirmNewpasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  void submit(void Function() onSuccess) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      if (newpasswordController.text != confirmNewpasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }
      isSubmitting.value = true;
      // TODO: Call API to change password
      isSubmitting.value = false;
      onSuccess();
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
}
