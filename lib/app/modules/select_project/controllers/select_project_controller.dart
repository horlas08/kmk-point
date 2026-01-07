import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../login/repository/auth_service.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../routes/app_pages.dart';
import '../../../common/widgets/notify.dart';
import '../../home/repository/home_service.dart';

class SelectProjectController extends GetxController {
  final activeProjectId = ''.obs;
  final activeOrgId = ''.obs;
  final projectController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    final box = Hive.box('auth');
    final savedProjectId = box.get('selectedProjectId')?.toString();
    final savedOrgId = box.get('selectedOrgId')?.toString();
    final savedProjectName = box.get('selectedProjectName')?.toString();

    if (savedProjectId != null && savedProjectId.isNotEmpty) {
      activeProjectId.value = savedProjectId;
    }
    if (savedOrgId != null && savedOrgId.isNotEmpty) {
      activeOrgId.value = savedOrgId;
    }
    if (savedProjectName != null && savedProjectName.isNotEmpty) {
      projectController.text = savedProjectName;
    }

    super.onInit();
  }
  
  showProjectSelectionBottomSheet() {
    Get.bottomSheet(
      Container(
        width: Get.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('حدد المشروع'),
            SizedBox(height: 16),
            ...authService.loginData.value!.organizationsProjectsPairs!.map((e) {
              return TouchableOpacity(

                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text("${e.projectName}"),
                ),
                onTap: () {
                  activeProjectId.value = "${e.projectId}";
                  activeOrgId.value = "${e.organizationId}";
                  projectController.text = "${e.projectName}- ${e.organizationName}";
                  final box = Hive.box('auth');
                  box.put('selectedProjectId', activeProjectId.value);
                  box.put('selectedOrgId', activeOrgId.value);
                  box.put('selectedProjectName', projectController.text);
                  log("${activeProjectId.value}");
                  Get.back();
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> continueToBaseView() async {
    try {
      if (formKey.currentState == null || !formKey.currentState!.validate()) {
        Notify.error('الرجاء اختيار المشروع');
        return;
      }
      if (activeProjectId.value.isEmpty) {
        Notify.error('لم يتم العثور على معرف المشروع المحدد');
        return;
      }

      final box = Hive.box('auth');
      box.put('selectedProjectId', activeProjectId.value);
      box.put('selectedOrgId', activeOrgId.value);
      box.put('selectedProjectName', projectController.text);

      Get.context?.loaderOverlay.show();
      final home = Get.isRegistered<HomeService>()
          ? Get.find<HomeService>()
          : Get.put(HomeService(), permanent: true);
      await home.fetchParticipantHome(projectId: activeProjectId.value);
      Get.context?.loaderOverlay.hide();
      Get.offAndToNamed(Routes.BASE_VIEW);
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
    }
  }
}
