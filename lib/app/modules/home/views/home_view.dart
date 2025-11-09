import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "points_system".tr,
                    style: headerSbPrimary.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),

                  TouchableOpacity(
                    onTap: () {
                      
                    },
                    child: Container(

                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBgLight,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: SvgPicture.asset(notificationSvg, fit: BoxFit.scaleDown,),
                    ),
                  )
                ],
              ),
              vSpace(16),
              Text("welcome_user".tr, style: textMediumBlack,),
              vSpace(8),
              Stack(
                children: [
                  Container(
                    height: 164,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12)
                    ),

                  ),
                  Positioned(
                    left: -70,
                    top: -70,
                    child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1)
                    ),
                    width: 160,
                    height: 160,
                  ),),
                  Positioned(
                    right: -40,
                    bottom: -40,
                    child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1)
                    ),
                    width: 97,
                    height: 97,
                  ),)
                ],
              )
            ],
          ),
        ),
      ))
    );
  }
}
