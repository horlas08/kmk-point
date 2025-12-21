import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../controllers/scan_history_controller.dart';

class ScanHistoryView extends GetView<ScanHistoryController> {
  const ScanHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // ensure fetch when visiting the page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        controller.fetch();
      } catch (_) {}
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSpace(16),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      " عمليات المسح السابقة",
                      style: textMediumBlack.copyWith(fontSize: 16),
                    ),
                    Spacer(),
                    TouchableOpacity(onTap: () => Get.offAndToNamed(Routes.BASE_VIEW), child: Icon(Icons.close, size: 24)),
                  ],
                ),
                vSpace(24),
                Text("scan_history".tr),
                vSpace(16),

                Obx(() {
                  final list = controller.history;
                  if (list.isEmpty) {
                    return Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text('no_scan_history'.tr),
                    ));
                  }
                  return Column(
                    children: list.map((item) => ScanHistroryCard(
                      points: item.points,
                      title: item.category,
                      showBadge: true,
                      badgeText: item.tag,
                      tag: item.tag,
                      createdAt: item.createdAt,
                    )).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ScanHistroryCard({
    required num points,
    required String title,
    String? tag,
    required String createdAt,
    bool showBadge = false,
    String? badgeText,
  }) {
    String date = createdAt;
    String time = '';
    if (createdAt.contains(' ')) {
      final parts = createdAt.split(' ');
      date = parts[0];
      time = parts.length > 1 ? parts[1] : '';
    }

    return Container(
      width: Get.width,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "+${points}",
                style: textMediumBlack.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF00A63E),
                ),
              ),
              Text("point".tr),
            ],
          ),
          hSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textRegularGrey.copyWith(
                    fontSize: 14,
                    color: Color(0xFF101828),
                  ),
                ),
                if (showBadge && badgeText != null)
                  Container(
                    margin: onlyPad(top: 5, bottom: 5),
                    padding: simPad(1.74, 10.6),
                    decoration: BoxDecoration(
                      color: Color(0xFFECEEF2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badgeText,
                      style: textRegularGrey.copyWith(
                        fontSize: 11,
                        color: Color(0xFF030213),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Spacer(),
                    if (date.isNotEmpty) Text(date),
                    hSpace(12),
                    Text('.'),
                    hSpace(12),
                    if (time.isNotEmpty) Text(time)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
