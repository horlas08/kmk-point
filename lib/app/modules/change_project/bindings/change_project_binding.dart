import 'package:get/get.dart';

import '../controllers/change_project_controller.dart';

class ChangeProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeProjectController>(
      () => ChangeProjectController(),
    );
  }
}
