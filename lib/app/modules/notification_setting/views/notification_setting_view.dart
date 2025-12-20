import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';
import 'package:point_system/app/common/widgets/space.dart';

import '../../../common/style/text_style.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  const NotificationSettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'notifications'.tr,),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.stroke),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SvgPicture.asset(notificationSvg),
                hSpace(10),
                Text('notifications'.tr, style: textMediumBlack),
                Spacer(),
                Obx(() => Switch(
                  value: controller.isEnabled.value,
                  onChanged: (v) => controller.toggleNotification(v),
                )),
              ],
            ),
          ),

          ],
        ),
      ),
    );
  }
}
