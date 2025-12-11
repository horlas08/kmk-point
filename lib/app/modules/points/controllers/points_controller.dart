import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../widgets/request_reward.dart';
import '../widgets/request_reward_sucessful.dart';

class PointsController extends GetxController {
  final points = [
    {
      "title": "إكمال واجب المنزلي",
      "status": "تمت الإضافة",
      "action": "حفظ",
      "point": "200+",
      "balance": "نقطة الرصيد: 654",
      "date": "15 أكتوبر 2025",
    },
    {
      "title": "إكمال واجب المنزلي",
      "status": "تمت الإضافة",
      "action": "حفظ",
      "point": "200+",
      "balance": "نقطة الرصيد: 654",
      "date": "15 أكتوبر 2025",
    },
  ].obs;
  final selectRewardController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Get.context?.loaderOverlay.show();
    Future.delayed(Duration(seconds: 2), () {

    });
    Get.context?.loaderOverlay.hide();

  }

  showRequestReward() {
    return showDialog(
      context: Get.context!,
      fullscreenDialog: false,
      barrierDismissible: false,
      builder: (context) {
        return RequestReward();
      },
    );
  }
  showRequestRewardSuccessful() {
    return showDialog(
      context: Get.context!,
      fullscreenDialog: false,
      barrierDismissible: true,
      builder: (context) {
        return RequestRewardSuccessful();
      },
    );
  }
}
