import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/modules/change_project/controllers/change_project_controller.dart';

import '../widgets/request_reward.dart';
import '../widgets/request_reward_sucessful.dart';
import '../../select_project/controllers/select_project_controller.dart';
import '../repository/points_service.dart';
import '../../../common/widgets/notify.dart';

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
  showRequestRewardSuccessfulOrError({bool status = true, String? message}) {
    return showDialog(
      context: Get.context!,
      fullscreenDialog: false,
      barrierDismissible: true,
      builder: (context) {
        return RequestRewardSuccessful(error: status, message: message??'',);
      },
    );
  }

  Future<void> submitRequestReward() async {
    final rewardId = selectRewardController.text.trim();
    final notes = noteController.text.trim();
    if (rewardId.isEmpty) {
      Notify.error('الرجاء اختيار المكافأة');
      return;
    }

    // Resolve project id
    String projectId = Get.find<SelectProjectController>().activeProjectId.value;

    if (projectId.isEmpty) {
      Notify.error('لم يتم تحديد المشروع');
      return;
    }

    try {
      // Ensure service
      final service = Get.isRegistered<PointsService>()
          ? Get.find<PointsService>()
          : Get.put(PointsService());

      Get.context?.loaderOverlay.show();
      final res = await service.sendRequestReward(
        rewardId: rewardId,
        projectId: projectId,
        notes: notes.isEmpty ? null : notes,
      );
      Get.context?.loaderOverlay.hide();

      final data = res.data;
      final bool ok = data is Map && (data['status'] == true || data['code'] == 200);
      final String? msg = data is Map ? data['message']?.toString() : null;

      // Close the input dialog before showing result
      if (Get.isOverlaysOpen) Get.back();
      showRequestRewardSuccessfulOrError(status: ok, message: msg);
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      if (Get.isOverlaysOpen) Get.back();
      showRequestRewardSuccessfulOrError(status: false, message: e.toString());
    }
  }
}
