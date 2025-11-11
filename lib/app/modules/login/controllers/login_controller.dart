import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneOrIdController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  void submit() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      isSubmitting.value = true;
      // TODO: Hook up actual login logic/API here
      // After completing submission, set isSubmitting to false.
      isSubmitting.value = false;
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
