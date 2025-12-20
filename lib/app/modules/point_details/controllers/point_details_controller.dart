import 'package:get/get.dart';

import '../../../models/point_log.dart';
import '../repository/point_details_service.dart';

class PointDetailsController extends GetxController {
  final points = <PointLogItem>[].obs;

  late final PointDetailsService _service;

  @override
  void onInit() {
    super.onInit();
    _service = Get.isRegistered<PointDetailsService>()
        ? Get.find<PointDetailsService>()
        : Get.put(PointDetailsService());
  }

  Future<void> fetch({required String projectId}) async {
    final res = await _service.fetchPointLog(projectId: projectId);
    final data = res.data;
    if (data is Map && (data['status'] == true || data['code'] == 200)) {
      final list = (data['data'] as List? ?? [])
          .map((e) => PointLogItem.fromJson(e as Map<String, dynamic>))
          .toList();
      points.assignAll(list);
    } else {
      points.clear();
    }
  }
}
