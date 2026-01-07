import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../controllers/home_controller.dart';

class TopStudents extends StatelessWidget {
  const TopStudents({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      final topStudents = Get.find<HomeService>().participantHome.value?.topTenParticipants;

      return Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "top_students".tr,
              style: textMediumBlack.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            vSpace(24),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "rank".tr,
                    style: textMediumBlack.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "name".tr,
                    style: textMediumBlack.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "point".tr,
                    style: textMediumBlack.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final student = topStudents[index];
                return TouchableOpacity(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color:  index == 0
                                ? Color(0xFFFEF9C2)
                                : index == 1
                                ? Color(0xFFE5EEFF)
                                : index == 2
                                ? Color(0xFFFFEDD4)
                                : topStudents[index].isHighlighted ? Color(0XFFC4D3FF)
                                : Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.05)
                            )
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${student.order}#",
                                style: textMediumBlack.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            Expanded(
                              child: Text(
                                "${student.name}",
                                style: textMediumBlack.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),

                            SizedBox(
                              width: 50,
                              child: Text(
                                "${student.points}",
                                style: textMediumBlack.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(student.isHighlighted)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        child: Container(
                          color: AppColors.primary,
                          width: 5,

                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox.shrink();
              },
              itemCount: topStudents!.length,
            ),
          ],
        ),
      );
    });
  }
}
