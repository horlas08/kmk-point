import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/notify.dart';
import 'package:point_system/app/common/widgets/text_field.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../controllers/select_project_controller.dart';

class SelectProjectView extends GetView<SelectProjectController> {
  const SelectProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              vSpace(52),
              Text("نظام النقاط", style: textMediumBlack.copyWith(
                color: AppColors.primary,
                fontSize: 25,
                fontWeight: FontWeight.w700,

              ),textAlign: TextAlign.center,),
              Spacer(),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Text("قم بأختيار المشروع للمتابعة", style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    vSpace(8),
                    CustomInput(
                      itemHintText: "اختر المشروع",
                      itemController: controller.projectController,
                      prefixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء اختيار المشروع';
                        }
                        return null;
                      },

                      onTap: () {
                        controller.showProjectSelectionBottomSheet();
                      },
                      readOnly: true,
                    ),
                    vSpace(16),
                    CustomButton(text: "متابعة", onPressed: () {
                      controller.continueToBaseView();
                    },)
                  ]
                )
              ),
              Spacer(),


            ],
          ),
        ),
      ),
    );
  }
}
