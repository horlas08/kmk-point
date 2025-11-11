import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/base_view_controller.dart';

class BaseViewView extends GetView<BaseViewController> {
  const BaseViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.nestedPage[controller.activeIndex.value],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        activeIndex: controller.activeIndex.value,
        gapLocation: GapLocation.none,
        height: 92.h,
        notchSmoothness: NotchSmoothness.verySmoothEdge,

        onTap: (index) => controller.setActiveTab(index),
        itemCount: controller.nestedPage.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                controller.iconList[index],
                fit: BoxFit.scaleDown,
              ),
              Text(controller.tabNameList[index])
            ],
          );
        },

        //other params
      ),
    );
  }
}
