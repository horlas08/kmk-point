import 'package:get/get.dart' hide Response;
import 'package:loader_overlay/loader_overlay.dart';
import '../../../models/scan_history_item.dart';
import '../repository/scan_history_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class ScanHistoryController extends GetxController {
	late final ScanHistoryService _service;

	final history = <ScanHistoryItem>[].obs;

	@override
	void onInit() {
		super.onInit();
		_service = Get.isRegistered<ScanHistoryService>()
				? Get.find<ScanHistoryService>()
				: Get.put(ScanHistoryService());

		Future.microtask(() => fetch());

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
			return;
		}

		try {
			Get.context?.loaderOverlay.show();
			final res = await _service.fetchScanHistory(projectId: projectId);
			final data = res.data;
			if (data is Map && (data['status'] == true || data['code'] == 200)) {
				final list = (data['data'] as List? ?? [])
						.map((e) => ScanHistoryItem.fromJson(e as Map<String, dynamic>))
						.toList();
				history.assignAll(list);
			} else {
				history.clear();
			}
		} catch (e) {
			Get.context?.loaderOverlay.hide();
			history.clear();
		}
		finally{
			Get.context?.loaderOverlay.hide();
		}
	}
}
