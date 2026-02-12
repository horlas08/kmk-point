import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';

import '../../../common/widgets/text_field.dart';
import '../controllers/account_setting_controller.dart';

class AccountSettingView extends GetView<AccountSettingController> {
  const AccountSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "account_settings".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      lockSvg,
                      fit: BoxFit.scaleDown,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6.0),
                    Text("تغيير كلمة المرور"),
                  ],
                ),
                vSpace(16),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("current_password".tr),
                      CustomInput(
                        itemController: controller.currentPasswordController,
                        contentPadding: simPad(10, 12),
                      ),
                      vSpace(8),
                      Text("new_password".tr),
                      CustomInput(
                        contentPadding: simPad(10, 12),
                        itemController: controller.newpasswordController,
                      ),
                      Text("password_rules".tr),
                      vSpace(8),
                      Text("confirm_new_password_field".tr),
                      CustomInput(
                        contentPadding: simPad(10, 12),
                        itemController: controller.confirmNewpasswordController,
                      ),
                      vSpace(32),
                      CustomButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(saveSvg, fit: BoxFit.scaleDown),
                            hSpace(8),
                            Text("save_changes".tr, style: TextStyle(fontSize: 16, color: Colors.white),),
                          ],
                        ),
                        onPressed: () {
                          controller.submit();
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
    );
  }
}
