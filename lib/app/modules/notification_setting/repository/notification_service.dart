import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class NotificationService extends GetxService {
  Future<NotificationService> init() async => this;

  Future<Response> activateNotification({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.activateNotification(projectId);
    return api.patch(path);
  }

  Future<Response> deactivateNotification({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.deactivateNotification(projectId);
    return api.patch(path);
  }

  Future<Response> checkNotificationStatus({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.checkNotificationStatus(projectId);
    return api.get(path);
  }
}
