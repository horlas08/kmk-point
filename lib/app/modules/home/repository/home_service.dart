import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:point_system/app/constants/endpoint.dart';

import '../../../models/participant_home_page.dart';
import '../../../services/api/api_service.dart';

class HomeService extends GetxService {
  final Rxn<ParticipantHomePageData> participantHome = Rxn<ParticipantHomePageData>();

  Future<HomeService> init() async {
    return this;
  }

  Future<ParticipantHomePageData> fetchParticipantHome({required String projectId}) async {
    final api = Get.find<ApiService>();
    final String path = Endpoints.participantHomePage(projectId);

    final res = await api.get(path);

    
    final data = res.data;
    if (data is Map && (data['status'] == true || data['code'] == 200)) {
      final content = ParticipantHomePageData.fromJson((data['data'] ?? {}) as Map<String, dynamic>);
      participantHome.value = content;
      return content;
    }
    throw DioException(
      requestOptions: RequestOptions(path: path),
      error: data is Map ? (data['message']?.toString() ?? 'Unexpected error') : 'Unexpected error',
      type: DioExceptionType.badResponse,
      response: res,
    );
  }
}
