import 'package:get/get.dart';

import '../controllers/previous_scan_controller.dart';

class PreviousScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviousScanController>(
      () => PreviousScanController(),
    );
  }
}
