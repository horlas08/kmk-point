import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../select_project/controllers/select_project_controller.dart';
import '../repository/points_service.dart';
import '../../../models/point_summary.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/svg_path.dart';

class PointUsage extends StatelessWidget {
  const PointUsage({super.key});

  @override
  Widget build(BuildContext context) {
    // Resolve project id
    final projectId = Get.isRegistered<SelectProjectController>()
        ? Get.find<SelectProjectController>().activeProjectId.value
        : '';

    final future = () async {
      if (projectId.isEmpty) return null;
      final service = Get.isRegistered<PointsService>() ? Get.find<PointsService>() : Get.put(PointsService());
      final res = await service.fetchPointPageSummary(projectId: projectId);
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        return PointPageSummary.fromJson(data['data'] as Map<String, dynamic>);
      }
      return null;
    }();

    return Container(
      margin: EdgeInsets.only(top: 16),
      child: FutureBuilder<PointPageSummary?>(
        future: future,
        builder: (context, snap) {
          final loading = snap.connectionState == ConnectionState.waiting;
          final PointPageSummary? summary = snap.data;

          String addedText() {
            if (loading) return '';
            if (summary == null) return '0';
            return summary.totalAddedPoints.toString();
          }

          String usedText() {
            if (loading) return '';
            if (summary == null) return '0';
            return summary.totalUsedPoints.toString();
          }

          Widget numberWidget(String text) {
            if (loading) {
              return Shimmer(
                child: Container(
                  width: 80,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
              );
            }
            return Text(
              text,
              style: textMediumBlack.copyWith(
                color: Colors.black87,
                fontSize: 23,
              ),
            );
          }

          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    PointCardWidget(
                      isGradient: true,
                      gradientBg: LinearGradient(
                        colors: [Color(0xFFF0FDF4), Color(0xFFFFFFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                      borderColor: Color(0xFFB9F8CF),
                      iconBgColor: Color(0xFFB9F8CF),
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Color(0xFF00A63E),
                        size: 28,
                      ),
                      title: "points_added".tr,
                      point: addedText(),
                      numberWidget: numberWidget(addedText()),
                      extraWidget: null,
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
                        colors: [Color(0xFFFEF2F2), Color(0xFFFFFFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                      borderColor: Color(0xFFFFC9C9),
                      iconBgColor: Color(0xFFFFE2E2),
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Color(0xFFE7000B),
                        size: 28,
                      ),
                      title: "point_used".tr,
                      point: usedText(),
                      numberWidget: numberWidget(usedText()),
                      extraWidget: null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
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
  final Widget? numberWidget;

  const PointCardWidget({
    super.key,
    this.bgColor,
    required this.borderColor,
    required this.iconBgColor,
    required this.icon,
    required this.title,
    required this.point,
    this.extraWidget,
    this.numberWidget,
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
              numberWidget ?? Text(
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
