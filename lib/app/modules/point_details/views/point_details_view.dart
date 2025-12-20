import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../controllers/point_details_controller.dart';

import '../../../models/point_log.dart';

class PointDetailsView extends GetView<PointDetailsController> {
  const PointDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "تفاصيل النقاط",),
      body: Scaffold(

          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("تفاصيل النقاط", style: textMediumBlack.copyWith(
                            fontSize: 16,
                          ),),
                          vSpace(16),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.points.value.length,
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
                                              controller.points[index].title,
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
                                                controller.points[index].type,
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
                                          "point".tr,
                                          style: textMediumBlack,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("assets/image/point.png"),
                                        hSpace(8),
                                        Text(
                                          controller.points[index].points.toString(),
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
                                    Divider(color: AppColors.stroke, thickness: 1),
                                    vSpace(10),
                                    Row(
                                      children: [
                                        Text("${controller.points[index].walletBalanceAfter}"),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Image.asset("assets/image/calendar.png"),
                                            hSpace(4),
                                            Text(controller.points[index].date),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                            return vSpace(16);
                          },
                          )
                        ],
                    ),
                  ),
              ),
          ),
      )
    );
  }
}
