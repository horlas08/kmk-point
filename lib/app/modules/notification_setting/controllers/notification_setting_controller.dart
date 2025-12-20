import 'package:get/get.dart' hide Response;
import 'package:loader_overlay/loader_overlay.dart';
import '../../../common/widgets/notify.dart';
import '../../../services/api/api_service.dart';
import '../repository/notification_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class NotificationSettingController extends GetxController {
  final isEnabled = false.obs;

  late final NotificationService _service;

  @override
  void onInit() {
    super.onInit();
    _service = Get.isRegistered<NotificationService>()
        ? Get.find<NotificationService>()
        : Get.put(NotificationService());
    // attempt to fetch initial notification status for current project
    Future.microtask(() async {
      try {
        final projectId = Get.isRegistered<SelectProjectController>()
            ? Get.find<SelectProjectController>().activeProjectId.value
            : '';
        if (projectId.isEmpty) return;
        Get.context?.loaderOverlay.show();
        final res = await _service.checkNotificationStatus(projectId: projectId);
        Get.context?.loaderOverlay.hide();
        final data = res.data;
        if (data is Map && (data['status'] == true || data['code'] == 200)) {
          final enabled = data['data'] is Map ? data['data']['enabled'] == true : false;
          isEnabled.value = enabled;
        }
      } catch (e) {
        Get.context?.loaderOverlay.hide();
        // don't block user on init failure; just show notification
        Notify.error(e.toString());
      }
    });
  }

  Future<void> toggleNotification(bool enable) async {
    try {
      final projectId = Get.isRegistered<SelectProjectController>()
          ? Get.find<SelectProjectController>().activeProjectId.value
          : '';
      if (projectId.isEmpty) {
        Notify.error('please_select_project'.tr);
        return;
      }

      Get.context?.loaderOverlay.show();
      final res = enable
          ? await _service.activateNotification(projectId: projectId)
          : await _service.deactivateNotification(projectId: projectId);
      Get.context?.loaderOverlay.hide();

      final data = res.data;
      final ok = data is Map && (data['status'] == true || data['code'] == 200);
      if (ok) {
        isEnabled.value = enable;
        Notify.success(data['message']?.toString() ?? 'success'.tr);
      } else {
        Notify.error(data is Map ? data['message']?.toString() ?? 'error' : 'error');
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      Notify.error(e.toString());
    }
  }
}
