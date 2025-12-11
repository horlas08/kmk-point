import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../controllers/change_project_controller.dart';

class ChangeProjectView extends GetView<ChangeProjectController> {
  const ChangeProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    // locale-aware strings
    final isAr = Get.locale?.languageCode == 'ar';
    final title = isAr ? 'المشاريع' : 'Projects';
    final subtitle = isAr ? 'أنت الآن على مشروع' : 'You are now on a project';

    return Scaffold(
      appBar: CustomAppbar(title: title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // subtitle aligned to end for LTR or start for RTL to mimic attachment
              Align(
                alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                ),
              ),

              // Projects list
              Expanded(
                child: Obx(() {
                  final projects = controller.projects;
                  if (projects.isEmpty) {
                    return Center(child: Text(isAr ? 'لا توجد مشاريع' : 'No projects found'));
                  }

                  return ListView.separated(
                    itemCount: projects.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final p = projects[index];
                      final id = '${p.projectId}';
                      final selected = controller.selectedProjectId.value == id;

                      return TouchableOpacity(
                        activeOpacity: 0.7,
                        onTap: () => controller.selectProject(p),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected ? AppColors.primary : Colors.grey.withOpacity(0.15),
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(roadMapSvg, width: 24, height: 24, color: AppColors.primary),
                                ),
                              ),
                              // left checkbox (blue when selected)

                              SizedBox(width: 12),

                              // project name
                              Expanded(
                                child: Text(
                                  p.projectName ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              if(selected)
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected ? AppColors.primary : Colors.grey.withOpacity(0.3),
                                    width: 2,
                                  ),
                                  color: selected ? AppColors.primary.withOpacity(0.08) : Colors.white,
                                ),
                                child: selected
                                    ? Icon(Icons.check, color: AppColors.primary)
                                    : SizedBox.shrink(),
                              ),


                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

