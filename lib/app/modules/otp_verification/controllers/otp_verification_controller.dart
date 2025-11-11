import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class OtpVerificationController extends GetxController with GetTickerProviderStateMixin {
  final otpController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final remainingSeconds = 59.obs;
  final canResend = false.obs;
  Timer? _timer;

  void startTimer({int from = 59}) {
    _timer?.cancel();
    remainingSeconds.value = from;
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  String get formattedTime {
    final s = remainingSeconds.value;
    final mm = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  void resendOtp() {
    if (!canResend.value) return;
    // TODO: Trigger resend OTP API
    startTimer(from: 59);
  }

  bool validateAndProceed(void Function() onSuccess) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      onSuccess();
      return true;
    }
    return false;
  }
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

}
