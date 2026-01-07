import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import '../../../common/helper/helper.dart';
import '../../../models/auth_data.dart';
import '../../../routes/app_pages.dart';

import '../../login/repository/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = Hive.box('auth');
    final rawData = box.get("authData");

    if (rawData != null) {
      final loginData = deepParseMap(rawData);

      Get.find<AuthService>().loginData.value =
          AuthData.fromJson(loginData);
      return const RouteSettings(name: Routes.SELECT_PROJECT);

    }


    return null;
  }
}
