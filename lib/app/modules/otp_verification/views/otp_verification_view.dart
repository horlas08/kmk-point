import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/otptextfield.dart';
import '../../../common/widgets/space.dart';
import '../../../common/widgets/text_field.dart';
import '../../../constants/image_path.dart';
import '../../../constants/svg_path.dart';
import '../../../routes/app_pages.dart';
import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  vSpace(18),
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset(planeImage, height: 56, width: 56),
                  ),
                  vSpace(32),
                  Text(
                    "reset_password_title".tr,
                    style: textMediumBlack,
                    textAlign: TextAlign.center,
                  ),
                  vSpace(10),
                  AutoSizeText(
                    "enter_phone_for_otp".tr,
                    style: textRegularGrey,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  vSpace(40),
                  Form(
                    key: controller.formKey,
                    child: OTPTextField(
                      controller: controller.otpController,
                      focusNode: controller.focusNode,
                      // validator: FormValidator.isValidOTP,
                      onCompleted: (String otp) {
                        // controller.verifyOtp();
                      },
                    ),
                  ),
                  vSpace(8),
                  Text("otp_info".tr, style: textRegularGrey),
                  vSpace(40),
                  CustomButton(
                    text: "confirm".tr,
                    onPressed: () {
                      Get.toNamed(Routes.OTP_VERIFICATION);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
