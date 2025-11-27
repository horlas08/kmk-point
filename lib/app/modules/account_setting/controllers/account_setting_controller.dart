import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
}
