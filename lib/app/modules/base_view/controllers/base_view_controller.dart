import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/views/home_view.dart';

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
    HomeView(),
    HomeView(),
    HomeView(),
  ];

  final activeIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setActiveTab(tab) => activeIndex.value = tab;
}
