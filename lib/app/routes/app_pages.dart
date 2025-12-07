import 'package:get/get.dart';

import '../modules/account_setting/bindings/account_setting_binding.dart';
import '../modules/account_setting/views/account_setting_view.dart';
import '../modules/base_view/bindings/base_view_binding.dart';
import '../modules/base_view/middlewares/check_token.dart';
import '../modules/base_view/views/base_view_view.dart';
import '../modules/bonus_request/bindings/bonus_request_binding.dart';
import '../modules/bonus_request/views/bonus_request_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage_profile/bindings/manage_profile_binding.dart';
import '../modules/manage_profile/views/manage_profile_view.dart';
import '../modules/more/bindings/more_binding.dart';
import '../modules/more/views/more_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/point_details/bindings/point_details_binding.dart';
import '../modules/point_details/views/point_details_view.dart';
import '../modules/points/bindings/points_binding.dart';
import '../modules/points/views/points_view.dart';
import '../modules/previous_scan/bindings/previous_scan_binding.dart';
import '../modules/previous_scan/views/previous_scan_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/scan_history/bindings/scan_history_binding.dart';
import '../modules/scan_history/views/scan_history_view.dart';
import '../modules/scan_successful/bindings/scan_successful_binding.dart';
import '../modules/scan_successful/views/scan_successful_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [
        CheckToken()
      ]
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.BASE_VIEW,
      page: () => const BaseViewView(),
      binding: BaseViewBinding(),
    ),
    GetPage(
      name: _Paths.POINTS,
      page: () => const PointsView(),
      binding: PointsBinding(),
    ),
    GetPage(
      name: _Paths.BONUS_REQUEST,
      page: () => const BonusRequestView(),
      binding: BonusRequestBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () => const MoreView(),
      binding: MoreBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETTING,
      page: () => const AccountSettingView(),
      binding: AccountSettingBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PROFILE,
      page: () => const ManageProfileView(),
      binding: ManageProfileBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_SUCCESSFUL,
      page: () => const ScanSuccessfulView(),
      binding: ScanSuccessfulBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_HISTORY,
      page: () => const ScanHistoryView(),
      binding: ScanHistoryBinding(),
    ),
    GetPage(
      name: _Paths.POINT_DETAILS,
      page: () => const PointDetailsView(),
      binding: PointDetailsBinding(),
    ),
  ];
}
