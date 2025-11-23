import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/points/controllers/points_controller.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../constants/colors.dart';

class PointCard extends StatelessWidget {
  const PointCard({super.key});

  @override
  Widget build(BuildContext context) {
    if(!Get.isRegistered<PointsController>()){
      Get.put(PointsController());
    }
    final controller = Get.find<PointsController>();
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            "points".tr,
                            style: textMediumBlack.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      vSpace(12),
                      Text(
                        "1520",
                        style: textMediumBlack.copyWith(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),

                      vSpace(5),
                      Text(
                        "point".tr,
                        style: textRegularGrey.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Spacer(),
                  TouchableOpacity(
                    onTap: () {
                      controller.showRequestReward();
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

                  Container(
                    height: 22,
                    margin: EdgeInsets.only(left: 10),
                    padding: simPad(2, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                      color: Color(0xFF6788E3),
                    ),

                    child: Row(
                      children: [
                        Text(
                          "points_added".tr,
                          style: textRegularGrey.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        hSpace(5),
                        Icon(Icons.arrow_downward, size: 16, color: Colors.redAccent,),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 22,
                    margin: EdgeInsets.only(left: 10),
                    padding: simPad(2, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                      color: Color(0xFF6788E3),
                    ),

                    child: Row(
                      children: [
                        Text(
                          "points_used".tr,
                          style: textRegularGrey.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        hSpace(5),
                        Icon(Icons.arrow_upward, size: 16, color: Color(0xFF7BF1A8),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
