import 'dart:developer';

import 'package:get/get.dart';

import '../../login/repository/auth_service.dart';
import '../../../models/organization_project_pair.dart';
import '../../select_project/controllers/select_project_controller.dart';
import '../../home/repository/home_service.dart';
import '../../../routes/app_pages.dart';
import '../../../common/widgets/notify.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChangeProjectController extends GetxController {
  /// List of available projects from the logged in user
  final projects = <OrganizationProjectPair>[].obs;

  late final AuthService _authService;

  /// Proxy to the globally-used SelectProjectController activeProjectId
  RxString get selectedProjectId => Get.find<SelectProjectController>().activeProjectId;
  RxString get selectedOrgId => Get.find<SelectProjectController>().activeOrgId;

  @override
  void onInit() {
    super.onInit();
    _authService = Get.find<AuthService>();
    final pairs = _authService.loginData.value?.organizationsProjectsPairs ?? [];
    projects.assignAll(pairs);
    final selectCtrl = Get.find<SelectProjectController>();
  // debug: show whether SelectProjectController is registered and current value
  log('SelectProjectController registered=${Get.isRegistered<SelectProjectController>()} activeProjectId="${selectCtrl.activeProjectId.value}" ${Get.find<SelectProjectController>().activeProjectId}');

    // initialize selected with first project if available
    // if (projects.isNotEmpty) {
    //   final first = projects.first;
    //   final selectCtrl = Get.isRegistered<SelectProjectController>()
    //       ? Get.find<SelectProjectController>()
    //       : Get.put(SelectProjectController());
    //   selectCtrl.activeProjectId.value = '${first.projectId}';
    //   selectCtrl.activeOrgId.value = '${first.organizationId}';
    // }
  }

  /// Select a project using the shared SelectProjectController so selection
  /// is consistent across the app and other controllers can react.
  void selectProject(OrganizationProjectPair pair) {
    final selectCtrl = Get.find<SelectProjectController>();
  // safe conversion: avoid assigning the literal string 'null' or an actual null
  selectCtrl.activeProjectId.value = pair.projectId != null ? '${pair.projectId}' : '';
  selectCtrl.activeOrgId.value = pair.organizationId != null ? '${pair.organizationId}' : '';
  // Force a rebuild of the projects list so the selected card updates immediately
  // projects.refresh();
    // Trigger project change API directly (Option B): fetch participant home for the
    // selected project and update HomeService.participantHome. Do NOT change UI here.
    try {
      Get.context?.loaderOverlay.show();
    } catch (_) {}

    () async {
    try {
    final home = Get.isRegistered<HomeService>()
      ? Get.find<HomeService>()
      : Get.put(HomeService(), permanent: true);
    await home.fetchParticipantHome(projectId: selectCtrl.activeProjectId.value);
    // ensure UI rebuild once fetch updates HomeService
    projects.refresh();
    // Optionally notify success
    // Notify.success('Project switched');
      } catch (e) {
        Notify.error(e.toString());
      } finally {
        try {
          Get.context?.loaderOverlay.hide();
        } catch (_) {}
      }
    }();
  }
}
