import 'package:get/get.dart' hide Response;
import 'package:loader_overlay/loader_overlay.dart';
import '../../../models/notification_item.dart';
import '../../home/repository/home_service.dart';
import '../repository/notifications_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class NotificationsController extends GetxController {
  late final NotificationsService _service;

  final notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _service = Get.isRegistered<NotificationsService>()
        ? Get.find<NotificationsService>()
        : Get.put(NotificationsService());

    // initial fetch
    Future.microtask(() => fetch());

    // listen to project changes
    if (Get.isRegistered<SelectProjectController>()) {
      final select = Get.find<SelectProjectController>();
      ever(select.activeProjectId, (_) => fetch());
    }
  }

  Future<void> fetch() async {
    final select = Get.isRegistered<SelectProjectController>()
        ? Get.find<SelectProjectController>()
        : null;
    final projectId = select?.activeProjectId.value ?? '';
    if (projectId.isEmpty) {
      notifications.clear();
      return;
    }

    try {
      Get.context?.loaderOverlay.show();
      final res = await _service.fetchNotifications(projectId: projectId);
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        final list = (data['data']['latest_notifications'] as List? ?? [])
            .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
            .toList();
        notifications.assignAll(list);
      } else {
        notifications.clear();
      }
    } catch (e) {
      notifications.clear();
      Get.context?.loaderOverlay.hide();
    } finally {
      Get.find<HomeService>().participantHome.value = Get.find<HomeService>().participantHome.value?.copyWith(
        unreadNotificationsCount: 0
      );
      Get.context?.loaderOverlay
          .hide();
    }
  }
}
