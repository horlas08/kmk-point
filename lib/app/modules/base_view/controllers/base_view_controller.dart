import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/bonus_request/views/bonus_request_view.dart';
import 'package:point_system/app/modules/home/views/home_view.dart';
import 'package:point_system/app/modules/more/views/more_view.dart';

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

}
