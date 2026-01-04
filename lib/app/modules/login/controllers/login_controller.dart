import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/models/auth_data.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:point_system/app/modules/login/repository/auth_service.dart';

import '../../../common/widgets/notify.dart';

class LoginController extends GetxController {
  final phoneOrIdController = TextEditingController(text: "");//012345678945
  final passwordController = TextEditingController(text: "");//123456789
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  Future<void> submit() async {
    final form = formKey.currentState;
    try{
      if (form != null && form.validate()) {
        Get.context?.loaderOverlay.show();
        final loginRes = await Get.find<AuthService>().login(
          identifier: phoneOrIdController.value.text,
          password: passwordController.value.text,
        );
        Get.context?.loaderOverlay.hide();
        if(loginRes.statusCode == HttpStatus.ok){
          Get.find<AuthService>().loginData.value = AuthData.fromJson(loginRes.data['data']);
          await Hive.box("auth").put('accessToken', loginRes.data['data']['token']);
          log(loginRes.data['data']['token']);

          Notify.success(loginRes.data['message']);
          Get.offAllNamed(Routes.SELECT_PROJECT);
        }else{
          throw Exception(loginRes.data['message']);
        }
      }
    }catch (error) {
      print(error);
      Get.context?.loaderOverlay.hide();
      Notify.error(error.toString(), );

    }

  }
}
