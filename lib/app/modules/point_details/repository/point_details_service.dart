import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class PointDetailsService extends GetxService {
  Future<PointDetailsService> init() async {
    return this;
  }

  Future<Response> fetchPointLog({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.pointLog(projectId);
    return api.get(path);
  }
}
