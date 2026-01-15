import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/controllers/home_controller.dart';
import 'package:point_system/app/modules/points/controllers/points_controller.dart';
import 'package:point_system/app/modules/select_project/controllers/select_project_controller.dart';
import 'package:point_system/app/modules/point_details/repository/point_details_service.dart';
import 'package:point_system/app/modules/point_details/controllers/point_details_controller.dart';
import 'package:point_system/app/models/point_log.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../constants/colors.dart';

class PointDetails extends StatelessWidget {
  const PointDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PointsController());
    final pointController = Get.find<PointsController>();

    // Resolve project id
    final projectId = Get.isRegistered<SelectProjectController>()
        ? Get.find<SelectProjectController>().activeProjectId.value
        : '';

    // If no project selected we hide the widget
    if (projectId.isEmpty) return SizedBox.shrink();

    // If PointDetailsController has data, use it; otherwise fetch via service
    final hasDetailsController = Get.isRegistered<PointDetailsController>();
    final pointDetailsController = hasDetailsController
        ? Get.find<PointDetailsController>()
        : Get.put(PointDetailsController());
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 295),
        child: Column(
          children: [
            if (pointDetailsController.points.isNotEmpty)
              Row(
                children: [
                  Text("تفاصيل النقاط".tr, style: textMediumBlack),
                  Spacer(),
                  TouchableOpacity(
                    onTap: () {
                      Get.toNamed(Routes.POINT_DETAILS);
                    },
                    child: Text(
                      "عرض المزيد",
                      style: textMediumBlack.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            vSpace(16),
            SizedBox(
              height: 220,

              child: Obx(() {
                if (pointDetailsController.isLoading.value) {
                  return Center(child: CupertinoActivityIndicator());
                }
                final list = pointDetailsController.points.take(5).toList();
                if (list.isEmpty) return SizedBox.shrink();
                return _buildList(context, list);
              }),
            ),
          ],
        ),
      );
    });

    // moved _buildList to class-level method to avoid referenced-before-declaration errors
  }

  Widget _buildList(BuildContext context, List<PointLogItem> list) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Container(
            // In a horizontal ListView the child's width is unconstrained.
            // Provide a finite width so widgets like Spacer / Expanded inside
            // the item's Rows can layout correctly.
            width: 280,
            height: 220,
            padding: simPad(16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: item.type == 'added'
                          ? Color(0xFFDCFCE7)
                          : Color(0xFFFCE0DC),
                      radius: 24,
                      child: SvgPicture.asset(
                        item.type == 'added'
                            ? "assets/svg/rise.svg"
                            : "assets/svg/dip.svg",
                        height: 23,
                        width: 23,
                      ),
                    ),
                    hSpace(11),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: textMediumBlack),
                        vSpace(4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: item.type == 'added'
                                ? Color(0xFFDCFCE7)
                                : Color(0xFFFCE0DC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item.type.tr),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                if (item.type == 'added')
                  Row(
                    children: [
                      Image.asset("assets/image/book.png"),
                      hSpace(8),
                      Text(item.tag, style: textMediumBlack),
                    ],
                  ),
                Row(
                  children: [
                    Image.asset("assets/image/point.png", color: item.type != 'added'?Colors.red : null,),
                    hSpace(8),
                    Text(
                      item.type == 'added'
                          ? "${item.points.toString()}+"
                          : "${item.points.toString()}-",
                      style: textMediumBlack.copyWith(color:item.type != 'added'?Colors.red :Color(0xFF008236), fontSize: 16),
                    ),
                    hSpace(2),
                    Text(
                      'point'.tr,
                      style: textMediumBlack.copyWith(color: item.type != 'added'?Colors.red :Color(0xFF008236)),
                    ),
                  ],
                ),
                vSpace(12),
                Divider(color: AppColors.grey, thickness: 1),
                vSpace(10),
                Row(
                  children: [
                    Text('محفظة: ${list[index].walletBalanceAfter}'),
                    Spacer(),
                    Row(
                      children: [
                        Image.asset("assets/image/calendar.png"),
                        hSpace(4),
                        Text(item.date),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => hSpace(16),
      ),
    );
  }
}
