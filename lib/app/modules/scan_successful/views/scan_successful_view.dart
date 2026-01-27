import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/image_path.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../controllers/scan_successful_controller.dart';

class ScanSuccessfulView extends GetView<ScanSuccessfulController> {
  const ScanSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: simPad(10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TouchableOpacity(
                  onTap: () => Get.offAndToNamed(Routes.BASE_VIEW),
                  child: Icon(Icons.close, size: 24),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(successImage, fit: BoxFit.scaleDown),
                    vSpace(60),
                    Text(
                      "success".tr,
                      style: headerSbPrimary.copyWith(color: Colors.black),
                    ),
                    vSpace(4),
                    Text("points_added_to_your_balance".tr),
                    vSpace(43),
                    Text("points_earned".tr),
                    vSpace(4),
                  ],
                ),
              ),
              vSpace(11),
              Text.rich(
                TextSpan(
                  text: "${controller.addedPoint}+",
                  children: [
                    TextSpan(text: "point".tr, style: TextStyle(fontSize: 16)),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF00A63E),
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                ),
              ),
              vSpace(24),
              Center(child: SizedBox(width: 300, child: Divider(height: 1))),
              vSpace(24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    starFourSvg,
                    color: AppColors.primary,
                    fit: BoxFit.scaleDown,
                  ),
                  hSpace(4),

                  Text(controller.category),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    starFourSvg,
                    color: AppColors.primary,
                    fit: BoxFit.scaleDown,
                  ),
                  hSpace(4),

                  Text(controller.tag),
                ],
              ),
              Spacer(),
              CustomButton(
                text: "previous_scans".tr,
                onPressed: () {
                  Get.toNamed(Routes.SCAN_HISTORY);
                },
              ),
              vSpace(16),
              CustomButton(
                isOutline: true,
                text: "scan_again".tr,
                onPressed: () => Get.back(),
              ),
              SizedBox(height: 50),

            ],
          ),
        ),
      ),
    );
  }
}
