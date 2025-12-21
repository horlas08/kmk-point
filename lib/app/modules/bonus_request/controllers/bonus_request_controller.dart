import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../points/controllers/points_controller.dart';
import '../repository/bonus_request_service.dart';
import '../../../models/reward_request.dart';
import '../../select_project/controllers/select_project_controller.dart';

class BonusRequestController extends GetxController {
  late final BonusRequestService _service;

  final history = <RewardRequestHistoryItem>[].obs;

  final accepted = 0.obs;
  final pending = 0.obs;
  final rejected = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _service = Get.isRegistered<BonusRequestService>()
        ? Get.find<BonusRequestService>()
        : Get.put(BonusRequestService());
    // fetch initial data if project already selected
    Future.microtask(() => fetch());

    // listen to project selection changes and refetch whenever project changes
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
      history.clear();
      accepted.value = 0;
      pending.value = 0;
      rejected.value = 0;
      return;
    }

    try {
      Get.context?.loaderOverlay.show();
      final res = await _service.fetchRequestRewardStatAndHistory(projectId: projectId);
      final data = res.data;
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        final body = data['data'] as Map<String, dynamic>? ?? {};
        final parsed = RewardRequestStatAndHistory.fromJson(body);
        accepted.value = parsed.statistics.accepted;
        pending.value = parsed.statistics.pending;
        rejected.value = parsed.statistics.rejected;
        history.assignAll(parsed.history);
      } else {
        history.clear();
        accepted.value = 0;
        pending.value = 0;
        rejected.value = 0;
      }
    } catch (e) {
      Get.context?.loaderOverlay.hide();
      history.clear();
      accepted.value = 0;
      pending.value = 0;
      rejected.value = 0;
    }
    finally{
      Get.context?.loaderOverlay.hide();
    }
  }

}
