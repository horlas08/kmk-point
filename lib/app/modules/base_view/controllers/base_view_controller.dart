import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/bonus_request/views/bonus_request_view.dart';
import 'package:point_system/app/modules/home/controllers/home_controller.dart';
import 'package:point_system/app/modules/home/views/home_view.dart';
import 'package:point_system/app/modules/more/views/more_view.dart';
import 'package:point_system/app/modules/select_project/controllers/select_project_controller.dart';

import '../../points/views/points_view.dart';

class BaseViewController extends GetxController {
  final iconList = [
    homeSvg,
    starFourSvg,
    giftSvg,
    moreSvg,
  ];
  final tabNameList = [
    "home".tr,
    "points".tr,
    "reward_requests".tr,
    "more".tr,
  ];
  final List<Widget> nestedPage = [
    HomeView(),
    PointsView(),
    BonusRequestView(),
    MoreView(),
  ];

  final activeIndex = 0.obs;

  void setActiveTab(tab) => activeIndex.value = tab;

  @override
  void onInit() {
    log("${Get.find<SelectProjectController>().activeProjectId}");
    log("${Get.find<SelectProjectController>().activeProjectId.value}");

    ever<int>(activeIndex, (index) {
      if (index == 0 && Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshHome();
      }
    });

    super.onInit();
  }

}
