import 'package:get/get.dart';

import '../controllers/base_view_controller.dart';
import '../../home/controllers/home_controller.dart';

class BaseViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseViewController>(
      () => BaseViewController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
