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
  final passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final isSubmitting = false.obs;

  @override
  void onClose() {
    phoneOrIdController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

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
          await Hive.box("auth").put('accessToken', Get.find<AuthService>().loginData.value?.token?? "");
          await Hive.box("auth").put(Get.find<AuthService>().loginData.value?.toJson(), 'authData');
          Notify.success(loginRes.data['message']);
          final selectedProjectId = Hive.box('auth').get('selectedProjectId')?.toString();
          if (selectedProjectId != null && selectedProjectId.isNotEmpty) {
            Get.offAllNamed(Routes.BASE_VIEW);
          } else {
            Get.offAllNamed(Routes.SELECT_PROJECT);
          }
        }else{
          throw Exception(loginRes.data['message']);
        }
      }
    }catch (error) {
      Get.context?.loaderOverlay.hide();
      Notify.error(error.toString(), );

    }

  }
}
