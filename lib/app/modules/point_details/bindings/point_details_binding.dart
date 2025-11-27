import 'package:get/get.dart';

import '../controllers/point_details_controller.dart';

class PointDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointDetailsController>(
      () => PointDetailsController(),
    );
  }
}
