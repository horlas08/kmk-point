import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class BonusRequestService extends GetxService {
  Future<BonusRequestService> init() async {
    return this;
  }

  Future<Response> fetchRequestRewardStatAndHistory({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.requestRewardStatAndHistory(projectId);
    return api.get(path);
  }
}
