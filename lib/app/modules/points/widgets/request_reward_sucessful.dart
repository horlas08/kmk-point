import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/common/widgets/text_field.dart';

import '../controllers/points_controller.dart';

class RequestRewardSuccessful extends StatelessWidget {
  final bool error;
  final String message;

   const RequestRewardSuccessful({super.key, this.error = false,  this.message = ''});

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
          height: 200,
          width: 343,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: allPad(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (error) SvgPicture.asset("assets/svg/success.svg")
              else Image.asset("assets/image/error.png"),

              vSpace(24),
              Text(message, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
