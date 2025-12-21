import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/modules/home/widgets/home_card.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../controllers/points_controller.dart';
import '../widgets/point_details.dart';
import '../widgets/point_usage.dart';
import '../widgets/point_card.dart';

class PointsView extends GetView<PointsController> {
  const PointsView({super.key});
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
                    // PointCard(),
                    HomeCard(isHome: false,),
                    PointUsage(),
                    PointDetails(),

                  ],
                ),
              ),
            ))
    );
  }
}
