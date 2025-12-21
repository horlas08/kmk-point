import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/image_path.dart';
import 'package:point_system/app/modules/login/repository/auth_service.dart';
import 'package:point_system/app/routes/app_pages.dart';

import '../../../common/style/text_style.dart';
import '../../../constants/svg_path.dart';
import '../controllers/more_controller.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: simPad(16, 16),
                  margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    border: Border.all(color: Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Obx(() {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Get
                              .find<AuthService>()
                              .loginData
                              .value!
                              .student!
                              .image == null ? Image.asset(
                            profileImage,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ) : Image.network(
                            Get
                                .find<AuthService>()
                                .loginData
                                .value!
                                .student!
                                .image!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        vSpace(9),
                        Text(
                          "وليد محمد ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        vSpace(9),
                        Text("رقم الهاتف: 54521456", style: textRegularGrey),
                        vSpace(9),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              starFourSvg,
                              width: 13,
                              height: 13,
                              fit: BoxFit.scaleDown,
                              color: AppColors.primary,
                            ),
                            hSpace(5),
                            Text(
                              "points".tr,
                              style: textMediumBlack.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                Account(),
                More()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Account() {
    return Container(
      padding: simPad(16, 16),
      margin: EdgeInsets.only(top: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("account".tr, style: textMediumBlack),
          vSpace(16),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.MANAGE_PROFILE),
            child: Container(
              padding: allPad(16),
              margin: onlyPad(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBgLight,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SvgPicture.asset(userSvg, fit: BoxFit.scaleDown),
                    ),
                  ),
                  hSpace(16),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("profile".tr, style: textMediumBlack),
                        AutoSizeText(
                          "view_edit_profile".tr,
                          style: textRegularGrey.copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.CHANGE_PROJECT),
            child: Container(
              padding: allPad(16),
              margin: onlyPad(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBgLight,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SvgPicture.asset(
                          changeProjectSvg, fit: BoxFit.scaleDown),
                    ),
                  ),
                  hSpace(16),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("change_project".tr, style: textMediumBlack),
                        AutoSizeText(
                          "change_project_from_here".tr,
                          style: textRegularGrey.copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
            child: Container(
              padding: allPad(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBgLight,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: SvgPicture.asset(settingSvg, fit: BoxFit.scaleDown),
                  ),
                  hSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("account_settings".tr, style: textMediumBlack),
                      AutoSizeText(
                        "manage_preferences".tr,
                        style: textRegularGrey.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget More() {
    return Container(
      padding: simPad(16, 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("more".tr, style: textMediumBlack),
          vSpace(16),
          GestureDetector(
            onTap: ()=> Get.toNamed(Routes.NOTIFICATION_SETTING),
            child: Container(
              padding: allPad(16),
              margin: onlyPad(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBgLight,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: SvgPicture.asset(
                        notificationSvg, fit: BoxFit.scaleDown),
                  ),
                  hSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("notifications".tr, style: textMediumBlack),
                      AutoSizeText(
                        "إدارة تفضيلات الإشعارات".tr,
                        style: textRegularGrey.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.SCAN_HISTORY),
            child: Container(
              padding: allPad(16),
              margin: onlyPad(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.stroke),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBgLight,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SvgPicture.asset(
                          supportSvg, fit: BoxFit.scaleDown),
                    ),
                  ),
                  hSpace(16),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("help_support".tr, style: textMediumBlack),
                        AutoSizeText(
                          "احصل على المساعدة واتصل بالدعم",
                          style: textRegularGrey.copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: allPad(16),
              margin: onlyPad(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFFFC9C9)),
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFEF2F2),
                    Color(0xFFFFFFFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
              ),
              child: Row(
                children: [
                  Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE2E2),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Icon(Icons.login_rounded, color: Color(0xFFE7000B),
                        size: 24,)
                  ),
                  hSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("logout".tr, style: textMediumBlack.copyWith(
                          color: Color(0xFFE7000B)
                      )),

                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
