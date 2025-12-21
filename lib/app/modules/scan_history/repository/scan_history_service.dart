import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class ScanHistoryService extends GetxService {
  Future<ScanHistoryService> init() async => this;

  Future<Response> fetchScanHistory({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.scanHistory(projectId);
    return api.get(path);
  }
}
