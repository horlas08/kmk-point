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
        ? Get
        .find<SelectProjectController>()
        .activeProjectId
        .value
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
            if(pointDetailsController.points.isNotEmpty)
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

              child: Builder(
                builder: (context) {
                  if (pointDetailsController.points.isNotEmpty) {
                    // defensively handle cases where the registered controller's points
                    // may contain Map instances (legacy) or PointLogItem instances.
                    // final raw = pointDetailsController.points;
                    List<
                        PointLogItem> listFromController = pointDetailsController
                        .points.take(5).toList();


                    if (listFromController.isNotEmpty) {
                      return _buildList(context, listFromController);
                    }
                  }

                  // otherwise fetch via service
                  return FutureBuilder(
                    future: PointDetailsService().fetchPointLog(
                      projectId: projectId,
                    ),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CupertinoActivityIndicator());
                      }
                      if (snapshot.hasError) return SizedBox.shrink();
                      final res = snapshot.data;
                      final data = res.data;
                      final List<PointLogItem> list =
                      (data is Map &&
                          (data['status'] == true || data['code'] == 200))
                          ? (data['data'] as List? ?? [])
                          .map(
                            (e) =>
                            PointLogItem.fromJson(
                              e as Map<String, dynamic>,
                            ),
                      )
                          .take(5)
                          .toList()
                          : <PointLogItem>[];
                      if (list.isEmpty) return SizedBox.shrink();
                      return _buildList(context, list);
                    },
                  );
                },
              ),
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
                      backgroundColor: Color(0xFFDCFCE7),
                      radius: 24,
                      child: SvgPicture.asset(
                        "assets/svg/rise.svg",
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
                            color: Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item.type),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Image.asset("assets/image/book.png"),
                    hSpace(8),
                    Text(item.title, style: textMediumBlack),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/image/point.png"),
                    hSpace(8),
                    Text(
                      item.points.toString(),
                      style: textMediumBlack.copyWith(color: Color(0xFF008236)),
                    ),
                    hSpace(2),
                    Text(
                      'point'.tr,
                      style: textMediumBlack.copyWith(color: Color(0xFF008236)),
                    ),
                  ],
                ),
                vSpace(12),
                Divider(color: AppColors.grey, thickness: 2),
                vSpace(10),
                Row(
                  children: [
                    Text('wallet: ${list[index].walletPointsAfter}'),
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
