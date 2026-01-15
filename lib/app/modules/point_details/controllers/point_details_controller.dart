import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/point_log.dart';
import '../repository/point_details_service.dart';
import '../../select_project/controllers/select_project_controller.dart';

class PointDetailsController extends GetxController {
  final points = <PointLogItem>[].obs;
  final isLoading = false.obs;
  String currentProjectId = '';

  late final PointDetailsService _service;

  @override
  void onInit() {
    super.onInit();
    _service = Get.isRegistered<PointDetailsService>()
        ? Get.find<PointDetailsService>()
        : Get.put(PointDetailsService());
    
    // Fetch data if project is selected and listen for changes
    final selectController = Get.find<SelectProjectController>();
    ever(selectController.activeProjectId, (id) {
      if (id.isNotEmpty && id != currentProjectId) {
        currentProjectId = id;
        fetch(projectId: id);
      }
    });
    // Initial fetch if already selected
    if (selectController.activeProjectId.value.isNotEmpty) {
      currentProjectId = selectController.activeProjectId.value;
      fetch(projectId: selectController.activeProjectId.value);
    }
  }

  Future<void> refreshCurrentProject({bool force = false}) async {
    final selectController = Get.find<SelectProjectController>();
    final id = selectController.activeProjectId.value;
    if (id.isEmpty) return;
    if (force) {
      currentProjectId = id;
    }
    await fetch(projectId: id);
  }

  Future<void> fetch({required String projectId}) async {
    isLoading.value = true;
    try {
      final res = await _service.fetchPointLog(projectId: projectId);
      final data = res.data;
      log( 'Point Details: $data' );
      if (data is Map && (data['status'] == true || data['code'] == 200)) {
        final list = (data['data'] as List? ?? [])
            .map((e) => PointLogItem.fromJson(e as Map<String, dynamic>))
            .toList();
        points.assignAll(list);
      } else {
        points.clear();
      }
    } catch (e) {
      points.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
