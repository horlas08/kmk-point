import 'dart:ui';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';
import 'package:point_system/app/modules/login/repository/auth_service.dart';
import 'package:point_system/app/modules/select_project/controllers/select_project_controller.dart';

class HomeController extends GetxController {
  late final HomeService homeService;
  late final List<Map<String, dynamic>> topStudents;
  final List<Map<String, dynamic>> rankingStyleDetails = [
    {
      "icon": engineSvg,
      "posistionBgColor": Color(0xFFE5EEFF),
      "BadgeBgColor": Color(0xFFE5EEFF),
      "BadgeStrokeColor": Color(0xFF8FA5E6)
    },
    {
      "icon": cupSvg,
      "posistionBgColor": Color(0xFFFDC700),
      "BadgeBgColor": Color(0xFFFEF9C2),
      "BadgeStrokeColor": Color(0xFFFDC700)
    },

    {
      "icon": bagdeSvg,
      "posistionBgColor": Color(0xFFF5C0C0),
      "BadgeBgColor": Color(0xFFFFEDD4),
      "BadgeStrokeColor": Color(0xFFF5C0C0)
    },

  ];

  @override
  void onInit() {
    super.onInit();
    homeService = Get.find<HomeService>();
    // Populate topStudents from participantHome data
    if (homeService.participantHome.value != null) {
      topStudents = homeService.participantHome.value!.topTenParticipants
          .map((participant) => {
                "position": participant.order,
                "name": participant.name,
                "point": participant.points,
              })
          .toList();
    } else {
      topStudents = [];
    }
  }

  @override
  void onReady() {
    super.onReady();
    refreshHome();
  }

  Future<void> refreshHome() async {
    final activeProjectId = Get.find<SelectProjectController>().activeProjectId.value;
    if (activeProjectId.isEmpty) return;

    Get.context?.loaderOverlay.show();
    try {
      await Get.find<AuthService>().fetchUser();
      final home = Get.isRegistered<HomeService>()
          ? Get.find<HomeService>()
          : Get.put(HomeService(), permanent: true);
      await home.fetchParticipantHome(projectId: activeProjectId);

    } finally {
      Get.context?.loaderOverlay.hide();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
