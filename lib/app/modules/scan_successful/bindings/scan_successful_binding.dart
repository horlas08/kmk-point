import 'package:get/get.dart';

import '../controllers/scan_successful_controller.dart';

class ScanSuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanSuccessfulController>(
      () => ScanSuccessfulController(),
    );
  }
}
