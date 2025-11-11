import 'package:get/get.dart';

import '../controllers/base_view_controller.dart';

class BaseViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseViewController>(
      () => BaseViewController(),
    );
  }
}
