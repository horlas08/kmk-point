import 'package:flutter/cupertino.dart';
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
    return GetX<PointDetailsController>(
      initState: (_) async {
        await controller.refreshCurrentProject(force: true);
      },
      builder: (_) {
        return Scaffold(
          appBar: CustomAppbar(title: "تفاصيل النقاط"),
          body: Scaffold(
            body: SafeArea(
              child: Visibility(
                visible: !controller.isLoading.value,
                replacement: Center(child: CupertinoActivityIndicator(),),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "تفاصيل النقاط",
                          style: textMediumBlack.copyWith(fontSize: 16),
                        ),
                        vSpace(16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.points.length,
                          itemBuilder: (context, index) {
                            final item = controller.points[index];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.title,
                                              style: textMediumBlack),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                      Image.asset(
                                        "assets/image/point.png",
                                        color: item.type != 'added'
                                            ? Colors.red
                                            : null,
                                      ),
                                      hSpace(8),
                                      Text(
                                        item.type == 'added'
                                            ? "${item.points.toString()}+"
                                            : "${item.points.toString()}-",
                                        style: textMediumBlack.copyWith(
                                          color: item.type != 'added'
                                              ? Colors.red
                                              : Color(0xFF008236),
                                        ),
                                      ),
                                      hSpace(2),
                                      Text(
                                        'point'.tr,
                                        style: textMediumBlack.copyWith(
                                          color: item.type != 'added'
                                              ? Colors.red
                                              : Color(0xFF008236),
                                        ),
                                      ),
                                    ],
                                  ),
                                  vSpace(12),
                                  Divider(color: AppColors.grey, thickness: 1),
                                  vSpace(10),
                                  Row(
                                    children: [
                                      Text(
                                        "اﻟرﺻﯾد: ${controller.points[index].walletBalanceAfter}",
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/image/calendar.png"),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
