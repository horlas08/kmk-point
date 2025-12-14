import 'dart:ui';

import 'package:get/get.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';

class HomeController extends GetxController {
  late final HomeService homeService;
  late final List<Map<String, dynamic>> topStudents;
  final List<Map<String, dynamic>> rankingStyleDetails = [
    {
      "icon": cupSvg,
      "posistionBgColor": Color(0xFFFDC700),
      "BadgeBgColor": Color(0xFFFEF9C2),
      "BadgeStrokeColor": Color(0xFFFDC700)
    },
    {
      "icon": engineSvg,
      "posistionBgColor": Color(0xFFE5EEFF),
      "BadgeBgColor": Color(0xFFE5EEFF),
      "BadgeStrokeColor": Color(0xFF8FA5E6)
    },
    {
      "icon": bagdeSvg,
      "posistionBgColor": Color(0xFFF5C0C0),
      "BadgeBgColor": Color(0xFFFFEDD4),
      "BadgeStrokeColor": Color(0xFFF5C0C0)
    },

  ];
  final topRanking = [
    {"rank": 1, "name": "محمد علي", "points": 3000},
    {"rank": 2, "name": "عبدالله الرافي عبدالحميد", "points": 2900},
    {"rank": 3, "name": "عبدالرحمن أحمد", "points": 2800},
    {"rank": 4, "name": "عبدالله الرافي", "points": 2700},
    {"rank": 5, "name": "وليد محمد", "points": 2600},
    {"rank": 6, "name": "سالم يوسف", "points": 2500},
    {"rank": 7, "name": "فهد عبدالعزيز", "points": 2400},
    {"rank": 8, "name": "خالد محمود", "points": 2300},
    {"rank": 9, "name": "عمر حسين", "points": 2200},
    {"rank": 10, "name": "عبدالله سعيد", "points": 2100},
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
  }

  @override
  void onClose() {
    super.onClose();
  }
}
