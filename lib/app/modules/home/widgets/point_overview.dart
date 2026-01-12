import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';

import '../../../models/participant_home_page.dart';
import '../repository/home_service.dart';

class PointOverview extends StatelessWidget {
  const PointOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final homeService = Get.find<HomeService>();

    return Obx(() {
      final HomePageStatistics homeStat =
          homeService.participantHome.value!.homePageStatistics;

      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  PointCardWidget(
                    isGradient: true,
                    gradientBg: LinearGradient(
                      colors: [homeStat.week.growthDirection == 'down'
                          ? Color(0xFFFEF2F2): Color(0xFFF0FDF4), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                    ),
                    borderColor: homeStat.week.growthDirection == 'down'
                        ? Color(0xFFF8C8B9)
                        : Color(0xFFB9F8CF),
                    iconBgColor: homeStat.week.growthDirection == 'down'
                        ? Color(0xFFFFE2E2)
                        : Color(0xFFB9F8CF),
                    icon: Transform.rotate(
                      angle: homeStat.week.growthDirection == 'down' ? 160 : 0,
                      child: homeStat.week.growthDirection == 'neutral'
                          ? Icon(Icons.list_outlined, color: Colors.green)
                          : SvgPicture.asset(riseSvg, color: homeStat.week.growthDirection == 'down'? Colors.red: null,),
                    ),
                    title: "this_week".tr,
                    point: "${homeStat.week.points}",
                    extraWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        SvgPicture.asset( riseSvg, width: 16, height: 16, color: homeStat.week.growthDirection == 'down'? Colors.red: null,),
                        hSpace(5),
                        Text(
                          "${homeStat.week.growthLabel} ${homeStat.week.growthPercentage}%",
                          style: textRegularGrey.copyWith(
                            fontSize: 12.sp,
                            color: homeStat.week.growthDirection == 'down'? Colors.red: Color(0xFF00A63E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            hSpace(16),
            Expanded(
              child: Column(
                children: [
                  PointCardWidget(
                    isGradient: true,
                    gradientBg: LinearGradient(
                      colors: [Color(0xFFFAF5FF), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                    ),
                    borderColor: Color(0xFFE9D4FF),
                    iconBgColor: Color(0xFFF3E8FF),
                    icon: SvgPicture.asset(starSvg),
                    title: "this_month".tr,
                    point: '${homeStat.month.points}',
                    extraWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        SvgPicture.asset(
                          homeStat.month.growthDirection == 'down'?dipSvg: riseSvg,
                          width: 16,
                          height: 16,
                          color: Color(0xFF9810FA),
                        ),
                        hSpace(5),
                        Text(
                          "${homeStat.month.growthLabel} ${homeStat.month.growthPercentage}%",
                          style: textRegularGrey.copyWith(
                            fontSize: 12.sp,
                            color: Color(0xFF9810FA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PointCardWidget extends StatelessWidget {
  final Color? bgColor;
  final bool? isGradient;
  final Gradient? gradientBg;
  final Color borderColor;
  final Color iconBgColor;
  final Widget icon;
  final String title;
  final String point;
  final Widget? extraWidget;

  const PointCardWidget({
    super.key,
    this.bgColor,
    required this.borderColor,
    required this.iconBgColor,
    required this.icon,
    required this.title,
    required this.point,
    this.extraWidget,
    this.isGradient = false,
    this.gradientBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        gradient: isGradient == true ? gradientBg : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(backgroundColor: iconBgColor, child: icon, radius: 28),
          vSpace(8),
          Text(
            title,
            style: textRegularGrey.copyWith(
              fontSize: 16,
              color: Color(0xFF4A5565),
            ),
            textAlign: TextAlign.center,
          ),
          vSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                point,
                style: textMediumBlack.copyWith(
                  color: Colors.black87,
                  fontSize: 23,
                ),
              ),
              hSpace(5),
              Text(
                "point".tr,
                style: textRegularGrey.copyWith(
                  fontSize: 10,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Visibility(
            visible: extraWidget != null,
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: extraWidget,
            ),
          ),
        ],
      ),
    );
  }
}
