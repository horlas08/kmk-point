import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/space.dart';

import '../../constants/colors.dart';
import 'apptext.dart';
import 'connectivity.dart';

class ConnectionOverlay extends StatelessWidget {
  final Widget child;
  const ConnectionOverlay({
    super.key,
    required this.child,
    });
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectivityController>();
    return Stack(
      children: [
        child,
        Obx(() =>
        Visibility(
          visible: !controller.isConnected.value == false,
          replacement: SizedBox.shrink(),
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.primary,
              width: double.infinity,
              height: 30,
              child: Center(
                child: SemiTitle(
                  fontSize: 12,
                  color: Colors.white,
                  text: 'no_internet'.tr,
                  ),
              )
            ),
          ),
        ))
      ]);
  }
}