import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        controller.fetch();
      } catch (_) {}
    });
    return Scaffold(
      appBar: CustomAppbar(title: "notifications".tr),
      body: Obx(() {
        final list = controller.notifications;
        if (list.isEmpty) {
          return Center(child: Text('لا إخطارات'));
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: list.length,
          separatorBuilder: (_, __) => SizedBox.shrink(),
          itemBuilder: (context, index) {
            final n = list[index];
            // created_at expected format: "YYYY-MM-DD HH:MM:SS"
            String date = n.createdAt;
            String time = '';
            if (n.createdAt.contains(' ')) {
              final parts = n.createdAt.split(' ');
              date = parts[0];
              time = parts.length > 1 ? parts[1] : '';
            }
            return ReUseableNotificationCard(
              title: n.title,
              subtitle: n.message,
              date: date,
              time: time,
              type: n.type
              // type detection could be added based on payload
            );
          },
        );
      }),
    );
  }
}

Widget ReUseableNotificationCard({
  required String title,
  String? subtitle,
  String? date,
  String? time,
  Widget? icon,
  String? type,
}) {
  return Container(
    width: double.infinity,
    // design height similar to Figma 99dp
    // height: 100,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.stroke.withOpacity(1)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: type == "points_added"
              ? Color(0xFFDCFCE7)
              : type == "points_deducted"
              ? Color(0xFFFFE2E2)
              : type == "reward_approved"
              ? AppColors.primaryBgLight
              : type == "reward_rejected"
              ? Color(0xFFFFE2E2)
              : AppColors.primaryBgLight,
          child:
              icon ?? SvgPicture.asset(
                  type == "points_added"
                      ? riseSvg
                      : type == "points_deducted"
                      ?dipSvg
                      : type == "reward_approved"
                      ? boxAddSvg
                      : type == "reward_rejected"
                      ? boxAddSvg
                      : notificationSvg, width: 24, height: 24, color: type == "reward_rejected"? AppColors.error: type == "reward_approved"? AppColors.primary: null,),
        ),

        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textMediumBlack.copyWith(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              vSpace(6),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: textRegularGrey.copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              vSpace(12),
              Row(
                children: [
                  Spacer(),
                  Text(
                    '${date ?? ''} ${date != null && time != null ? '•' : ''} ${time ?? ''}',
                    style: textRegularGrey.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
