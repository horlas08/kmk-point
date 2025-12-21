import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class NotificationsService extends GetxService {
  Future<NotificationsService> init() async => this;

  Future<Response> fetchNotifications({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.notification(projectId);
    return api.get(path);
  }
}
