import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/common/widgets/text_field.dart';

import '../controllers/points_controller.dart';

class RequestReward extends StatelessWidget {
  const RequestReward({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PointsController>()) {
      Get.put(PointsController());
    }
    final controller = Get.find<PointsController>();
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 360,
          width: 343,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: allPad(24),
          child: Column(
            children: [
              Text(
                "add_reward_request".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              vSpace(24),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("reward_requests".tr, textAlign: TextAlign.start),
                    CustomInput(
                      itemController: controller.selectRewardController,
                      readOnly: true,
                      onTap: () {
                        controller.showRewardPicker();
                      },
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    vSpace(16),
                    Text("notes".tr),
                    CustomInput(
                      itemController: controller.noteController,
                      itemHintText: "write_notes".tr,
                      maxLines: 2,
                    ),
                    vSpace(16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(text: "confirm_request".tr,onPressed: () {
                            controller.submitRequestReward();
                          },),

                        ),
                        hSpace(27),
                        Expanded(
                          child: CustomButton(
                            isOutline: true,
                            text: "cancel".tr,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
