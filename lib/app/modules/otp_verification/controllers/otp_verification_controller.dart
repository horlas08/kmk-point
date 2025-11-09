import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController with GetTickerProviderStateMixin {
  final otpController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
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
