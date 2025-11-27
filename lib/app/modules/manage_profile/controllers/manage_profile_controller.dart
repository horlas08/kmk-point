import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageProfileController extends GetxController {
  final fullNameController = TextEditingController(text: "وليد محمد");
  final civilIdController = TextEditingController(text: "123-4567");
  final mobilePhoneController = TextEditingController(text: "+1 (555) 123-4567");
  final emailController = TextEditingController(text: "john.smith@school.edu");
}
