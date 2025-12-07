import 'package:get/get.dart';
import 'package:point_system/app/services/auth/auth_service.dart';

class CheckToken extends GetMiddleware{
  @override
  GetPage? onPageCalled(GetPage? page) {
    if(Get.find<AuthService>().loginData.value!.token!.isEmpty){
      Get.offAllNamed('/login');
    }
    return super.onPageCalled(page);
  }
}