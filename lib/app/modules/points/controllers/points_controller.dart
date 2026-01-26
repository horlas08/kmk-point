import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/modules/change_project/controllers/change_project_controller.dart';

import '../widgets/request_reward.dart';
import '../widgets/request_reward_sucessful.dart';
import '../../select_project/controllers/select_project_controller.dart';
import '../repository/points_service.dart';
import '../../../common/widgets/notify.dart';
import '../../../models/reward_request.dart';

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
  final selectedRewardId = ''.obs;
  final rewards = <Reward>[].obs;
  final isLoadingRewards = false.obs;

  @override
  void onInit() {
    super.onInit();
    Get.context?.loaderOverlay.show();
    Future.delayed(Duration(seconds: 2), () {

    });
    Get.context?.loaderOverlay.hide();

  }

  Future<void> fetchRewards() async {
    final projectId = Get.find<SelectProjectController>().activeProjectId.value;
    if (projectId.isEmpty) return;

    isLoadingRewards.value = true;
    try {
      final service = Get.isRegistered<PointsService>()
          ? Get.find<PointsService>()
          : Get.put(PointsService());
      final res = await service.getRewards(projectId: projectId);
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        final list = (data['data'] as List? ?? [])
            .map((e) => Reward.fromJson(e as Map<String, dynamic>))
            .toList();
        rewards.assignAll(list);
      } else {
        rewards.clear();
      }
    } catch (e) {
      rewards.clear();
    } finally {
      isLoadingRewards.value = false;
    }
  }

  void showRewardPicker() {
    fetchRewards();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Obx(() {
          if (isLoadingRewards.value) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Text("حدد نوع المكافأة", style: textMediumBlack,),
              SizedBox(height: 16),
              Divider(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  return ListTile(
                    enableFeedback: true,
                    style: ListTileStyle.drawer,

                    // leading: CircleAvatar(radius: 2, backgroundColor: Colors.black12,),
                    title: Text(reward.name),
                    onTap: () {
                      selectRewardController.text = reward.name;
                      selectedRewardId.value = reward.id.toString();
                      Get.back();
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  showRequestReward() {
    selectRewardController.clear();
    selectedRewardId.value = '';
    noteController.clear();
    return showDialog(
      context: Get.context!,
      fullscreenDialog: false,
      barrierDismissible: false,
      builder: (context) {
        return RequestReward();
      },
    );
  }
  Future<void> showRequestRewardSuccessfulOrError({bool status = true, String? message}) {
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
    final rewardId = selectedRewardId.value.trim();
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
      Get.back();
      await showRequestRewardSuccessfulOrError(status: ok, message: msg);
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      if (Get.isDialogOpen == true) Get.back();
      await showRequestRewardSuccessfulOrError(status: false, message: e.toString());
    }
  }
}
