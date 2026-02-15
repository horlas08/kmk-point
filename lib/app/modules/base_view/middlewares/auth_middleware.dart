import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import '../../../common/helper/helper.dart';
import '../../../models/auth_data.dart';
import '../../../models/participant_home_page.dart';
import '../../../routes/app_pages.dart';

import '../../home/repository/home_service.dart';
import '../../login/repository/auth_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = Hive.box('auth');
    final rawData = box.get("authData");
    final homeData = box.get('homeData');
    final savedProjectId = box.get('selectedProjectId')?.toString();
    final savedOrgId = box.get('selectedOrgId')?.toString();
    final savedProjectName = box.get('selectedProjectName')?.toString();
    final sp = Get.isRegistered<SelectProjectController>()
        ? Get.find<SelectProjectController>()
        : Get.put(SelectProjectController(), permanent: true);

    if (savedProjectId != null && savedProjectId.isNotEmpty) {
      sp.activeProjectId.value = savedProjectId;
    }
    if (savedOrgId != null && savedOrgId.isNotEmpty) {
      sp.activeOrgId.value = savedOrgId;
    }
    if (savedProjectName != null && savedProjectName.isNotEmpty) {
      sp.projectController.text = savedProjectName;
      sp.selectedProjectLabel.value = savedProjectName;
    }
    if (rawData != null) {
      final loginData = deepParseMap(rawData);

      Get.find<AuthService>().loginData.value = AuthData.fromJson(loginData);
      return const RouteSettings(name: Routes.SELECT_PROJECT);
    }
    if(homeData != null){
      Get.find<HomeService>().participantHome.value = ParticipantHomePageData.fromJson(jsonDecode(homeData));
    }
    if (box.get("accessToken") == null ||
        box.get("accessToken") == "" ||
        box.get("accessToken").isNullOrBlank) {
      return const RouteSettings(name: Routes.LOGIN);
    }else if (rawData == null) {
      return const RouteSettings(name: Routes.LOGIN);
    } else if(homeData == null){
      return const RouteSettings(name: Routes.SELECT_PROJECT);
    }
    else if (sp.activeProjectId.value.isEmpty || box.get("selectedProjectId") == null){
      return const RouteSettings(name: Routes.SELECT_PROJECT);
    }else if (sp.activeOrgId.value.isEmpty || box.get("selectedOrgId") == null){
      return const RouteSettings(name: Routes.SELECT_PROJECT);
    }else if( rawData != null && homeData != null && sp.activeProjectId.value.isNotEmpty && sp.activeOrgId.value.isNotEmpty ) {
      return const RouteSettings(name: Routes.BASE_VIEW);
    }


    return null;
  }
}
