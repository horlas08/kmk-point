import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/notify.dart';
import '../../account_setting/repository/profile_service.dart';
import '../../login/repository/auth_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class ManageProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final civilIdController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  final emailController = TextEditingController();

  File? selectedImage;

  late final ProfileService profileService;

  @override
  void onInit() {
    super.onInit();

   log(" ${Get.find<SelectProjectController>().activeProjectId}");

    profileService = Get.isRegistered<ProfileService>()
        ? Get.find<ProfileService>()
        : Get.put(ProfileService());

    // Prefill from AuthService.loginData
    if (Get.isRegistered<AuthService>()) {
      final auth = Get.find<AuthService>();
      final data = auth.loginData.value;
      final student = data?.student;
      final user = student?.user;

      final firstName = user?.firstName?.trim() ?? '';
      final lastName = user?.lastName?.trim() ?? '';
      final fullName = [firstName, lastName].where((e) => e.isNotEmpty).join(' ').trim();
      if (fullName.isNotEmpty) fullNameController.text = fullName;
      if ((student?.civilNumber ?? '').isNotEmpty) civilIdController.text = student!.civilNumber!;
      if ((student?.phone ?? '').isNotEmpty) mobilePhoneController.text = student!.phone!;
      if ((user?.email ?? '').isNotEmpty) emailController.text = user!.email!;
    }
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

  /// Pick an image from the gallery and store it in [selectedImage]
  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (picked != null) {
        selectedImage = File(picked.path);
        Notify.success('Selected image updated');
      }
    } catch (e) {
      Notify.error(e.toString());
    }
  }
}
