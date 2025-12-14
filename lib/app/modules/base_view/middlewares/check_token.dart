import 'package:get/get.dart';
import 'package:point_system/app/modules/login/repository/auth_service.dart';

class CheckToken extends GetMiddleware{
  @override
  GetPage? onPageCalled(GetPage? page) {
    if(Get.find<AuthService>().loginData.value!.token!.isEmpty){
      Get.offAllNamed('/login');
    }
    return super.onPageCalled(page);
  }
}