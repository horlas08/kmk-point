import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../constants/endpoint.dart';
import '../../../services/api/api_service.dart';

class PointsService extends GetxService {
  Future<PointsService> init() async {
    return this;
  }

  /// Send reward request
  /// Body: { reward_id, project_id, notes }
  Future<Response> sendRequestReward({
    required String rewardId,
    required String projectId,
    String? notes,
  }) async {
    final api = Get.find<ApiService>();
    return await api.post(
      Endpoints.sendRequestReward,
      data: {
        'reward_id': rewardId,
        'project_id': projectId,
        if ((notes ?? '').isNotEmpty) 'notes': notes,
      },
    );
  }

  /// Fetch points page summary for given project
  Future<Response> fetchPointPageSummary({required String projectId}) async {
    final api = Get.find<ApiService>();
    final path = Endpoints.getPointPageSummary(projectId);
    return api.get(path);
  }
}
