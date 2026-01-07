import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:point_system/app/routes/app_pages.dart';

import '../../../common/helper/helper.dart';
import '../../../models/auth_data.dart';
import '../../login/repository/auth_service.dart';

class CheckToken extends GetMiddleware{
  @override
  GetPage? onPageCalled(GetPage? page) {
    final box = Hive.box('auth');
    final token = box.get('accessToken')?.toString() ?? '';
    // final selectedProjectId = box.get('selectedProjectId')?.toString() ?? '';
    final currentRoute = page?.name;
    // final rawData = box.get("authData");
    //
    // if (rawData != null) {
    //   final loginData = deepParseMap(rawData);
    //
    //   Get.find<AuthService>().loginData.value =
    //       AuthData.fromJson(loginData);
    //   Get.toNamed(Routes.SELECT_PROJECT);
    //   // return super.onPageCalled(page);
    //
    // }

    return super.onPageCalled(page);
  }
}


