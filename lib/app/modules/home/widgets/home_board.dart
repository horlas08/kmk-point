import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:point_system/app/common/style/text_style.dart';
import 'package:point_system/app/common/widgets/space.dart';
import 'package:point_system/app/constants/svg_path.dart';
import 'package:point_system/app/modules/home/controllers/home_controller.dart';
import 'package:point_system/app/modules/home/repository/home_service.dart';
import 'dart:math' as math;

import '../../../models/participant_home_page.dart';

class HomeBoard extends StatelessWidget {
  const HomeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Obx(() {
      final students = Get.find<HomeService>().participantHome.value?.topTenParticipants;

      return Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 295),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFDBEAFE)),
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [Color(0xFFEFF6FF), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(rankingSvg),
                hSpace(6),
                Text("leaderboard".tr, style: textMediumBlack),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: () {
                  final styles = List<Map<String, dynamic>>.from(
                    homeController.rankingStyleDetails,
                  );
                  final cloned = List<TopParticipant>.from(students ?? const <TopParticipant>[]);
                  if (cloned.isEmpty) {
                    return <Widget>[];
                  }
                  final maxLen = math.min(3, cloned.length);
                  final visible = cloned.take(maxLen).toList();
                  final firstIndex = visible.indexWhere((s) => s.order == 1);
                  if (firstIndex != -1 && visible.length >= 3) {
                    final first = visible.removeAt(firstIndex);
                    visible.insert(1, first);
                  }
                  final useLen = math.min(visible.length, styles.length);
                  return List.generate(useLen, (index) {
                    final student = visible[index];
                    final style = styles[index];

                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: student.order == 1 ? 82 : 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: style['BadgeBgColor'],
                              border: Border.all(
                                width: 3,
                                color: style['BadgeStrokeColor'],
                              ),
                            ),
                            child: SvgPicture.asset(
                              style['icon'],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          vSpace(10),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: style['posistionBgColor'],
                            child: Text("${student.order}"),
                          ),
                          AutoSizeText(
                            student.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          vSpace(10),
                          Text(
                            "${student.points} ${"point".tr}",
                            textAlign: TextAlign.center,
                          ),
                          vSpace(10),
                        ],
                      ),
                    );
                  });
                }(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
