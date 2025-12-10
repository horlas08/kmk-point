import 'package:get/get.dart';

import '../controllers/select_project_controller.dart';

class SelectProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectProjectController>(
      () => SelectProjectController(),
    );
  }
}
