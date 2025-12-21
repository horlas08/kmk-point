import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/modules/bonus_request/views/widgets/bonus_card.dart';
import 'package:point_system/app/modules/points/controllers/points_controller.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../../../routes/app_pages.dart';
import '../controllers/bonus_request_controller.dart';

class BonusRequestView extends GetView<BonusRequestController> {
  const BonusRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PointsController>()) {
      Get.put(PointsController());
    }
    if (!Get.isRegistered<BonusRequestController>()) {
      Get.put(BonusRequestController());
    }
    // ensure data refreshes whenever user visits this page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final controller = Get.find<BonusRequestController>();
        controller.fetch();
      } catch (_) {}
    });
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
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
                          child: SvgPicture.asset(
                            notificationSvg, fit: BoxFit.scaleDown,),
                        ),
                      )
                    ],
                  ),
                  vSpace(16),
                  Column(
                    children: [
                      BonusCard(

                      ),
                      vSpace(25),
                      Container(
                        padding: simPad(16, 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.stroke,
                          ),
                        ),
                        child: Column(

                          children: [
                            Row(
                              children: [
                                Text("سجل الطلبات"),
                                Spacer(),
                                TouchableOpacity(
                                  onTap: () {
                                    Get
                                        .find<PointsController>()
                                        .showRequestReward();
                                  },
                                  child: Container(
                                    padding: simPad(12, 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        hSpace(5),
                                        Text(
                                          "reward_request".tr,
                                          style: textMediumBlack.copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            vSpace(25),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "reward".tr,
                                    style: textMediumBlack.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "date".tr,
                                    style: textMediumBlack.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "points_used".tr,
                                    style: textMediumBlack.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TouchableOpacity(
                                    child: Container(
                                      decoration: BoxDecoration(

                                          border: Border.all(
                                              color: Colors.black.withOpacity(
                                                  0.05)
                                          )
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 13),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              // use typed model fields from controller.history
                                              "${controller.history[index]
                                                  .reward}",
                                              style: textMediumBlack.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Text(
                                              "${controller.history[index]
                                                  .date}",
                                              style: textMediumBlack.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),

                                          Expanded(
                                            child: AutoSizeText(
                                              "${controller.history[index]
                                                  .point}",
                                              style: textMediumBlack.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox.shrink();
                                },
                                itemCount: controller.history.length,
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
