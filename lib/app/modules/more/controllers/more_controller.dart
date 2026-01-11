import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api/api_service.dart';
import '../../../common/widgets/notify.dart';

class MoreController extends GetxController {


  Future<void> openHelpSupport() async {
    try {
      Get.context?.loaderOverlay.show();
      final api = Get.find<ApiService>();
      final res = await api.get(Endpoints.settings);
      final data = res.data;
      
      Get.context?.loaderOverlay.hide();
      String? number;
      if (data is Map) {
        final inner = data['data'];
        if (inner is Map) {
          final raw = inner['whatsapp_number'];
          if (raw != null) number = raw.toString();
        }
      }

      if (number == null || number.isEmpty) {
        Notify.error('Whatsapp number not available', title: 'Error');
        return;
      }

      final digits = number.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits.isEmpty) {
        Notify.error('Invalid whatsapp number', title: 'Error');
        return;
      }

      final uri = Uri.parse('https://wa.me/$digits');
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) {
        Notify.error('Unable to open WhatsApp', title: 'Error');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error('Failed to open WhatsApp', title: 'Error');
    }
  }

  logout() async {
    await Hive.box("auth").delete("authData");
    await Hive.box("auth").delete("accessToken");
    await Hive.box("auth").delete("selectedProjectId");
    Get.toNamed(Routes.LOGIN);
  }
}
