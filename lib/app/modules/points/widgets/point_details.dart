import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/controllers/home_controller.dart';
import 'package:point_system/app/modules/points/controllers/points_controller.dart';

import '../../../constants/colors.dart';

class PointDetails extends StatelessWidget {
  const PointDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PointsController());
    final pointController = Get.find<PointsController>();
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 295),
      child: Column(
        children: [
          Row(
            children: [
              Text("تفاصيل النقاط".tr, style: textMediumBlack),
              Spacer(),
              Text(
                "عرض المزيد",
                style: textMediumBlack.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          vSpace(16),
          SizedBox(
            height: 220,

            child: ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: pointController.points.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 220,
                  padding: simPad(16, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: AppColors.grey,
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
                              Text(
                                pointController.points[index]['title']!,
                                style: textMediumBlack,
                              ),
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
                                child: Text(
                                  pointController.points[index]['status']!,
                                ),
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
                          Text(
                            pointController.points[index]['action']!,
                            style: textMediumBlack,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/image/point.png"),
                          hSpace(8),
                          Text(
                            pointController.points[index]['point']!,
                            style: textMediumBlack.copyWith(
                              color: Color(0xFF008236),
                            ),
                          ),
                          hSpace(2),
                          Text(
                            'point'.tr,
                            style: textMediumBlack.copyWith(
                              color: Color(0xFF008236),
                            ),
                          ),
                        ],
                      ),
                      vSpace(12),
                      Row(children: []),
                      Divider(color: AppColors.grey, thickness: 2),
                      vSpace(10),
                      Row(
                        children: [
                          Text(pointController.points[index]['balance']!),
                          hSpace(11),
                          Row(
                            children: [
                              Image.asset("assets/image/calendar.png"),
                              hSpace(4),
                              Text(pointController.points[index]['date']!),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return hSpace(16);
            },
            ),
          ),
        ],
      ),
    );
  }
}
