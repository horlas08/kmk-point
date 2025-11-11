import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;
  final count = 0.obs;

  void submit(void Function() onSuccess) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      isSubmitting.value = true;
      // TODO: Trigger send OTP API
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

  void increment() => count.value++;
}
