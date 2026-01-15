import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/custom_appbar.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/common/widgets/text_field.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/constants/image_path.dart';
import 'package:point_system/app/constants/svg_path.dart';

import '../../login/repository/auth_service.dart';
import '../controllers/manage_profile_controller.dart';

class ManageProfileView extends GetView<ManageProfileController> {
  const ManageProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'إدارة ملفك الشخصي'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: onlyPad(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(pictureImage, fit: BoxFit.scaleDown),
                          hSpace(8),
                          Text("profile_picture".tr, style: textMediumBlack),
                        ],
                      ),
                      vSpace(16),

                      Obx(() {
                        return Row(
                          children: [

                            ClipRRect(

                              borderRadius: BorderRadius.circular(13),
                              clipBehavior: Clip.hardEdge,

                              child: controller.selectedImage.value != null
                                  ? Image.file(
                                      controller.selectedImage.value!,
                                      height: 132,
                                      width: 132,
                                      fit: BoxFit.cover,
                                    )
                                  : Get.find<AuthService>()
                                            .loginData
                                            .value
                                            ?.student
                                            ?.image !=
                                        null
                                  ? Image.network(
                                      Get.find<AuthService>()
                                          .loginData
                                          .value!
                                          .student!
                                          .image!,
                                      fit: BoxFit.cover,
                                      height: 132,
                                      width: 132,
                                loadingBuilder: (context, child, loadingProgress) {
                                  return loadingProgress == null
                                      ? child
                                      : Center(
                                          child: CupertinoActivityIndicator(),
                                        );
                                },
                                    )
                                  : Image.asset(
                                      profileImage,
                                      fit: BoxFit.cover,
                                      height: 132,
                                      width: 132,

                                    ),

                            ),
                            hSpace(24),
                            Column(
                              children: [
                                SizedBox(
                                  width: 135,
                                  height: 34,
                                  child: CustomButton(
                                    isOutline: true,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          uploadSvg,
                                          color: AppColors.primary,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        hSpace(6),
                                        Text("upload_new_image".tr),
                                      ],
                                    ),
                                    onPressed: () async {
                                      await controller.pickImage();
                                    },
                                  ),
                                ),
                                vSpace(16),
                                Text("max_size".tr),
                              ],
                            ),
                          ],
                        );
                      }),
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("full_name".tr, style: textMediumBlack),
                            CustomInput(
                              itemController: controller.fullNameController,
                              contentPadding: simPad(10, 12),
                            ),
                            vSpace(20),
                            Text("civil_id".tr, style: textMediumBlack),
                            CustomInput(
                              prefixIcon: SvgPicture.asset(
                                idcardSvg,
                                fit: BoxFit.scaleDown,
                              ),
                              itemController: controller.civilIdController,
                              contentPadding: simPad(10, 12),
                            ),
                            vSpace(20),
                            Text("mobile_phone".tr, style: textMediumBlack),
                            CustomInput(
                              prefixIcon: SvgPicture.asset(
                                callSvg,
                                fit: BoxFit.scaleDown,
                              ),
                              itemController: controller.mobilePhoneController,
                              contentPadding: simPad(10, 12),
                            ),
                            vSpace(20),
                            Text("email".tr, style: textMediumBlack),
                            CustomInput(
                              prefixIcon: SvgPicture.asset(
                                emailSvg,
                                fit: BoxFit.scaleDown,
                              ),
                              itemController: controller.emailController,
                              contentPadding: simPad(10, 12),
                            ),
                            Text("student_email_info".tr),
                            vSpace(32),
                            CustomButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    saveSvg,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hSpace(8),
                                  Text(
                                    "save_changes".tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                controller.submitProfile();
                              },
                            ),
                            vSpace(32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
