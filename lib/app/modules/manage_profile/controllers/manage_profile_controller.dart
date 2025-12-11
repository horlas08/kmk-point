import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/widgets/notify.dart';
import '../../../services/profile/profile_service.dart';

class ManageProfileController extends GetxController {
  final fullNameController = TextEditingController(text: "وليد محمد");
  final civilIdController = TextEditingController(text: "123-4567");
  final mobilePhoneController = TextEditingController(text: "+1 (555) 123-4567");
  final emailController = TextEditingController(text: "john.smith@school.edu");

  File? selectedImage;

  late final ProfileService profileService;

  @override
  void onInit() {
    super.onInit();
    profileService = Get.isRegistered<ProfileService>()
        ? Get.find<ProfileService>()
        : Get.put(ProfileService());
  }

  /// Call this to submit the profile update. This will build a multipart/form-data
  /// payload and call the ProfileService.updateProfile method.
  Future<void> submitProfile() async {
    try {
      // Basic validation
      final fullName = fullNameController.text.trim();
      final email = emailController.text.trim();
      final civil = civilIdController.text.trim();
      final phone = mobilePhoneController.text.trim();

      if (fullName.isEmpty || email.isEmpty) {
        Notify.error('Please fill required fields');
        return;
      }

      // Attempt to split full name into first/last name (best-effort)
      final parts = fullName.split(RegExp(r"\s+"));
      final firstName = parts.isNotEmpty ? parts.first : fullName;
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

      Get.context?.loaderOverlay.show();

      final res = await profileService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        civilNumber: civil,
        phone: phone,
        image: selectedImage,
      );

      Get.context?.loaderOverlay.hide();

      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        Notify.success(data['message']?.toString() ?? 'Profile updated');
      } else {
        Notify.error(data is Map ? (data['message']?.toString() ?? 'Update failed') : 'Update failed');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
    }
  }
}
