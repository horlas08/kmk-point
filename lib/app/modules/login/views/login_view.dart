import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/common/widgets/text_field.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/custom_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                vSpace(52),
                Text(
                  "points_system".tr,
                  style: headerSbPrimary,
                  textAlign: TextAlign.center,
                ),
                vSpace(56),
                Text(
                  "welcome_back".tr,
                  style: textMediumBlack,
                  textAlign: TextAlign.center,
                ),
                vSpace(10),
                Text(
                  "login_to_continue".tr,
                  style: textMediumBlack,
                  textAlign: TextAlign.center,
                ),
                vSpace(10),
                AutoSizeText(
                  "enter_credentials".tr,
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
                        itemController: controller.phoneOrIdController,
                        itemHintText: "phone_or_id".tr,
                        validator: ValidationBuilder(localeName: "ar").required().build(),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(controller.passwordFocusNode);
                        },
                        prefixIcon: SvgPicture.asset(
                          userSvg,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          color: AppColors.formIcon,
                        ),
                      ),
                      vSpace(8),
                      CustomInput(
                        itemController: controller.passwordController,
                        itemHintText: "أدخل كلمة المرور الخاصة بك",
                        isAuthField: true,
                        validator: ValidationBuilder(localeName: "ar").required().build(),
                        focusNode: controller.passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        suffixIcon: SvgPicture.asset(eyeSvg),
                        prefixIcon: SvgPicture.asset(
                          lockSvg,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          color: AppColors.formIcon,
                        ),
                      ),
                    ],
                  ),
                ),
                vSpace(8),

                TouchableOpacity(
                  onTap: () {
                    Get.toNamed(Routes.FORGET_PASSWORD);
                  },
                  child: Text(
                    "forgot_password".tr,
                    style: textRegularGrey.copyWith(color: AppColors.primary),
                    textAlign: TextAlign.end,
                  ),
                ),
                vSpace(40),
                CustomButton(text: "login".tr, onPressed: controller.submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
