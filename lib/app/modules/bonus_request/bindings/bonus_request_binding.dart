import 'package:get/get.dart';

import '../controllers/bonus_request_controller.dart';

class BonusRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusRequestController>(
      () => BonusRequestController(),
    );
  }
}
