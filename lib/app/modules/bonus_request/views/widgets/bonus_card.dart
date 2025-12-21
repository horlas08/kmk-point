import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/bonus_request/controllers/bonus_request_controller.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../constants/colors.dart';

class BonusCard extends StatelessWidget {
  const BonusCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<BonusRequestController>()) {
      Get.put(BonusRequestController());
    }
    final controller = Get.find<BonusRequestController>();
    return Obx(() => Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    BonusCardWidget(
                      isGradient: true,
                      gradientBg: LinearGradient(
                        colors: [Color(0xFFF0FDF4), Color(0xFFFFFFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                      borderColor: Color(0xFFB9F8CF),
                      iconBgColor: Color(0xFFB9F8CF),
                      icon: SvgPicture.asset(
                        circleMarkSvg,
                        fit: BoxFit.scaleDown,
                      ),
                      title: "approved".tr,
                      status: "completed_requests".tr,
                      statusColor: Color(0xFF00A63E),
                      point: controller.accepted.value.toString(),
                    ),
                  ],
                ),
              ),
              hSpace(16),
              Expanded(
                child: Column(
                  children: [
                    BonusCardWidget(
                      isGradient: true,
                      gradientBg: LinearGradient(
                        colors: [Color(0xFFFEFCE8), Color(0xFFFFFFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                      ),
                      borderColor: Color(0xFFFFF085),
                      iconBgColor: Color(0xFFFEF9C2),
                      icon: Icon(
                        Icons.access_time_rounded,
                        size: 24,
                        color: Color(0xFFD08700),
                      ),
                      title: "pending".tr,
                      status: "under_review".tr,
                      statusColor: Color(0xFFD08700),
                      point: controller.pending.value.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        vSpace(20),
        BonusCardWidget(
          isGradient: true,
          gradientBg: LinearGradient(
            colors: [Color(0xFFFAF5FF), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
          showSpacer: true,
          borderColor: Color(0xFFE9D4FF),
          iconBgColor: Color(0xFFF3E8FF),
          icon: SvgPicture.asset(boxAddSvg,),
          title: "total_requests".tr,
          status: "under_review".tr,
          statusColor: Color(0xFF9810FA),
          point: (controller.accepted.value + controller.pending.value + controller.rejected.value).toString(),
        ),
      ],
    ));
  }
}

class BonusCardWidget extends StatelessWidget {
  final Color? bgColor;
  final bool? isGradient;
  final Gradient? gradientBg;
  final Color borderColor;
  final Color iconBgColor;
  final Widget icon;
  final String title;
  final Color statusColor;
  final String status;
  final String point;
  final bool showSpacer;
  final Widget? extraWidget;

  const BonusCardWidget({
    super.key,
    this.bgColor,
    required this.borderColor,
    required this.iconBgColor,
    required this.icon,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.point,
    this.extraWidget,
    this.showSpacer = false,
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
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textRegularGrey.copyWith(
                  fontSize: 16,
                  color: Color(0xFF4A5565),
                ),
                textAlign: TextAlign.center,
              ),
              vSpace(8),
              Text(
                point,
                style: textMediumBlack.copyWith(
                  color: Colors.black87,
                  fontSize: 23,
                ),
              ),
              hSpace(5),
              Text(
                status,
                style: textRegularGrey.copyWith(
                  fontSize: 10,
                  color: statusColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          if (showSpacer) Spacer(),
          Expanded(
            flex: showSpacer? 0:1,
            child: CircleAvatar(
              backgroundColor: iconBgColor,
              child: icon,
              radius: 28,
            ),
          ),
        ],
      ),
    );
  }
}
