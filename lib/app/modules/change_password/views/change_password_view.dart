import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/modules/change_password/controllers/change_password_controller.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/otptextfield.dart';
import '../../../common/widgets/space.dart';
import '../../../common/widgets/text_field.dart';
import '../../../constants/image_path.dart';
import '../../../constants/svg_path.dart';
import '../../../routes/app_pages.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

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
                    child: Image.asset(keyImage, height: 56, width: 56),
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
                    child: Column(
                      children: [
                        CustomInput(
                          itemController: controller.currentPasswordController,
                          itemHintText: "current_password".tr,
                          prefixIcon: SvgPicture.asset(
                            lockSvg,
                            fit: BoxFit.scaleDown,
                          ),
                          isAuthField: true,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'This field is required';
                            return null;
                          },
                        ),
                        vSpace(8),
                        CustomInput(
                          itemController: controller.newpasswordController,
                          itemHintText: "enter_new_password".tr,
                          prefixIcon: SvgPicture.asset(
                            lockSvg,
                            fit: BoxFit.scaleDown,
                          ),
                          isAuthField: true,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'This field is required';
                            if (v.length < 6) return 'Password too short';
                            return null;
                          },
                        ),
                        vSpace(8),
                        CustomInput(
                          itemController: controller.confirmNewpasswordController,
                          itemHintText: "confirm_new_password".tr,
                          prefixIcon: SvgPicture.asset(
                            lockSvg,
                            fit: BoxFit.scaleDown,
                          ),
                          isAuthField: true,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'This field is required';
                            if (v != controller.newpasswordController.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
                        vSpace(40),
                        CustomButton(
                          text: "confirm".tr,
                          onPressed: () {
                            controller.submit(() => Get.toNamed(Routes.LOGIN));
                          },
                        ),
                      ],
                    ),
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
