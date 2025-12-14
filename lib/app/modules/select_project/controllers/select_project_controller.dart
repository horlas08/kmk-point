import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
