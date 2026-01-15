import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:point_system/app/common/widgets/custom_button.dart';
import 'package:point_system/app/common/widgets/notify.dart';
import 'package:point_system/app/common/widgets/text_field.dart';
import 'package:point_system/app/routes/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../common/style/text_style.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/space.dart';
import '../../../constants/colors.dart';
import '../../../constants/svg_path.dart';
import '../../../models/organization_project_pair.dart';
import '../controllers/select_project_controller.dart';

class SelectProjectView extends GetView<SelectProjectController> {
  const SelectProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              vSpace(52),
              Text("نظام النقاط", style: textMediumBlack.copyWith(
                color: AppColors.primary,
                fontSize: 25,
                fontWeight: FontWeight.w700,

              ),textAlign: TextAlign.center,),
              Spacer(),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Text("قم بأختيار المشروع للمتابعة", style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    vSpace(8),
                    Obx(() {
                      final _ = controller.activeProjectId.value;
                      final __ = controller.authService.loginData.value;
                      return DropdownSearch<OrganizationProjectPair>(
                        items: (filter, loadProps) =>   controller.fetchProjectPairs(filter),
                        selectedItem: controller.initialSelectedPair,
                        itemAsString: (item) =>
                            '${item.projectName}- ${item.organizationName}',
                        compareFn: (item1, item2) => item1.projectId == item2.projectId,
                        validator: (value) {
                          if (controller.activeProjectId.value.isEmpty) {
                            return 'الرجاء اختيار المشروع';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.onProjectSelected(value);
                        },
                        // onBeforePopupOpening: (selectedItem) async{
                        //   await controller.fetchProjectPairs("");
                        //   return true;
                        // },
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            hintText: 'اختر المشروع',
                            suffixIcon:
                            const Icon(Icons.keyboard_arrow_down_rounded),
                            suffix: null,
                          ),


                        ),
                        popupProps: PopupProps.menu(
                          showSearchBox: false,
                          fit: FlexFit.tight,
                          // constraints: BoxConstraints.expand(),
                          menuProps: MenuProps(
                            align: MenuAlign.bottomStart,
                            margin: EdgeInsets.symmetric(vertical: 60),


                            borderRadius: BorderRadius.circular(16)

                          ),
                          emptyBuilder: (context, searchEntry) {
                            return Center(
                              child: Text(
                                "لا يوجد مشاريع",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, searchEntry) =>  Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      );
                    }),
                    vSpace(16),
                    CustomButton(text: "متابعة", onPressed: () {
                      controller.continueToBaseView();
                    },)
                  ]
                )
              ),
              Spacer(),


            ],
          ),
        ),
      ),
    );
  }
}
