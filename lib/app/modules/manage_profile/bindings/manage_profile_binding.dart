import 'package:get/get.dart';

import '../../select_project/controllers/select_project_controller.dart';
import '../controllers/manage_profile_controller.dart';

class ManageProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageProfileController>(
      () => ManageProfileController(),
    );
    Get.lazyPut<SelectProjectController>(
      () => SelectProjectController(),
    );
  }
}
