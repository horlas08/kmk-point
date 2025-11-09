import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/common/widgets/text_field.dart';
import 'package:point_system/app/constants/image_path.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/routes/app_pages.dart';

import '../../../common/style/text_style.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

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
                  CustomInput(itemController: controller.phoneController, itemHintText: "enter_phone".tr, prefixIcon: SvgPicture.asset(callSvg, fit: BoxFit.scaleDown,),),
                  vSpace(8),
                  Text("otp_info".tr, style: textRegularGrey),
                  vSpace(40),
                  CustomButton(text: "confirm".tr, onPressed: () {
                    Get.toNamed(Routes.OTP_VERIFICATION);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
