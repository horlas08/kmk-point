import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';
import 'package:point_system/app/modules/points/controllers/points_controller.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../constants/colors.dart';

class HomeCard extends StatelessWidget {
  final bool isHome;
  const HomeCard({super.key, this.isHome = true});

  @override
  Widget build(BuildContext context) {
    final homeService = Get.find<HomeService>();
    return Obx(() {
      final participantData = homeService.participantHome.value;
      final walletPoints = participantData?.walletInfo.walletPoints ?? 0;
      final walletBalance = participantData?.walletInfo.walletBalance ?? 0;
      final currentRank = participantData?.currentParticipantRank ?? 0;
      final projectName = participantData?.walletInfo.projectName;

      return Stack(
        children: [
          Container(
            height: 180,

            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
            left: -70,
            top: -70,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              width: 160,
              height: 160,
            ),
          ),
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              width: 97,
              height: 97,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$projectName", style: textMediumBlack.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),),
                        vSpace(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              starFourSvg,
                              width: 13,
                              height: 13,
                              fit: BoxFit.scaleDown,
                              color: Colors.white,
                            ),
                            hSpace(5),
                            Text(
                              "balance".tr,
                              style: textMediumBlack.copyWith(
                                fontSize: 14,
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        vSpace(12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              walletBalance.toString(),
                              style: textMediumBlack.copyWith(
                                color: Colors.white,
                                fontSize: 23,
                                height: 1,
                              ),

                            ),
                            hSpace(5),
                            Text(
                              "point".tr,
                              style: textRegularGrey.copyWith(
                                fontSize: 10,
                                color: Colors.white,
                                height: 1
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    if(isHome)
                    Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: SvgPicture.asset(
                        cupSvg,
                        fit: BoxFit.scaleDown,
                        width: 43,
                        height: 43,
                        color: Colors.white,
                      ),
                    )
                    else
                      TouchableOpacity(
                        onTap: () {
                          if(!Get.isRegistered<PointsController>()) {
                            Get.put(PointsController());
                          }
                          Get.find<PointsController>().showRequestReward();
                        },
                        child: Container(
                          padding: simPad(12, 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primary,
                                size: 16,
                              ),
                              hSpace(5),
                              Text(
                                "reward_request".tr,
                                style: textMediumBlack.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                vSpace(15),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "points".tr,
                          style: textRegularGrey.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            height: 2,
                          ),
                        ),
                        hSpace(12),
                        Text(
                          walletPoints.toString(),
                          style: textMediumBlack.copyWith(
                            color: Colors.white,
                            fontSize: 23,
                            height: 1,
                          ),
                        ),
                        hSpace(5),
                        Text(
                          "point".tr,
                          style: textRegularGrey.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            height: 1
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 22,
                      margin: EdgeInsets.only(left: 10),
                      padding: simPad(2, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Color(0xFF6788E3),
                      ),

                      child: Text("${"rank".tr} #$currentRank", style: textRegularGrey.copyWith(
                        fontSize: 10,
                        color: Colors.white,

                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
