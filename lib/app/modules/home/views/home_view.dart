import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/widgets/home_board.dart';
import 'package:point_system/app/modules/home/widgets/home_card.dart';
import 'package:point_system/app/modules/home/widgets/point_overview.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:point_system/app/modules/login/repository/auth_service.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../controllers/home_controller.dart';
import '../widgets/top_students.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final student = Get.find<AuthService>().loginData.value!.student;

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  Column(
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
                      Get.toNamed(Routes.NOTIFICATIONS);
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
              Text("${'welcome_user'.tr} ${student?.user?.username ??student?.user?.firstName}", style: textMediumBlack,),
              vSpace(8),
              HomeCard(),
              PointOverview(),
              HomeBoard(),
              TopStudents(),
              vSpace(20),
            ],
          ),
        ),
      ))
    );
  }
}
