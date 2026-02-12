import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../../constants/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/api_service.dart';

class OtpVerificationController extends GetxController with GetTickerProviderStateMixin {
  final otpController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final remainingSeconds = 59.obs;
  final canResend = false.obs;
  Timer? _timer;
  late final String email;

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

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    try {
      Get.context?.loaderOverlay.show();
      final api = Get.find<ApiService>();
      final res = await api.post(Endpoints.resendOtp, data: {
        'email': email,
      });
      Get.context?.loaderOverlay.hide();
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        Notify.success(data['message']?.toString() ?? 'OTP resent');
        startTimer(from: 59);
      } else {
        Notify.error(data is Map ? (data['message']?.toString() ?? 'Failed to resend OTP') : 'Failed to resend OTP');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
    }
  }

  bool validateAndProceed(void Function() onSuccess) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      _verifyOtpAndProceed(onSuccess);
      return true;
    }
    return false;
  }

  Future<void> _verifyOtpAndProceed(void Function() onSuccess) async {
    try {
      final otp = otpController.text.trim();
      Get.context?.loaderOverlay.show();
      final api = Get.find<ApiService>();
      final res = await api.post(Endpoints.verifyResetOtp, data: {
        'email': email,
        'otp': otp,
      });
      Get.context?.loaderOverlay.hide();
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        Notify.success(data['message']?.toString() ?? 'Verified');
        // Extract reset_token from response data
        final dynamic payload = data['data'];
        final String? resetToken = payload is Map ? (payload['reset_token']?.toString()) : (data['reset_token']?.toString());
        if (resetToken == null || resetToken.isEmpty) {
          Notify.error('reset_token missing in response');
          return;
        }
        Get.toNamed(Routes.RESET_PASSWORD, arguments: {
          'reset_token': resetToken,
        });
        return;
        onSuccess();
      } else {
        Notify.error(data is Map ? (data['message']?.toString() ?? 'Verification failed') : 'Verification failed');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
    }
  }
  @override
  void onInit() {
    super.onInit();
    email = (Get.arguments?['email'] ?? '').toString();
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
