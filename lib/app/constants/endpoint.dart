sealed class Endpoints {
  static const String login = "/points-plugin/login";
  static const String changePassword = "/points-plugin/participant/change-password";
  static const String updateProfile = "/points-plugin/update-profile";
  static const String requestResetOtp = "/points-plugin/password/request-otp";
  static const String verifyResetOtp = "/points-plugin/password/verify-otp";
  static const String resetPassword = "/points-plugin/password/reset";
  static const String qrCode = "/points-plugin/scan-qr";
  static const String sendRequestReward = "/points-plugin/send-reward-request";
  static const String settings = "/points-plugin/settings";
  static String participantHomePage(String projectId) =>
      "/points-plugin/projects/$projectId/participant-home-page";
   static String pointLog(String projectId) =>
      "/points-plugin/projects/$projectId/participant-points-log";
 static String getPointPageStat(String projectId) =>
      "/points-plugin/projects/$projectId/participant-points-page";
 static String getPointPageSummary(String projectId) =>
      "/points-plugin/projects/$projectId/participant-points-summary";
 static String activateNotification(String projectId) =>
      "/points-plugin/projects/$projectId/notifications/activate";
 static String deactivateNotification(String projectId) =>
      "/points-plugin/projects/$projectId/notifications/deactivate";
 static String checkNotificationStatus(String projectId) =>
      "/points-plugin/projects/$projectId/notifications/status";
 static String requestRewardStatAndHistory(String projectId) =>
      "/points-plugin/projects/$projectId/reward-requests-statistics-and-history";
 // static String scanHistory(String projectId) =>
 //      "/points-plugin/projects/$projectId/scan-history";
static String notification(String projectId) =>
      "/points-plugin/projects/$projectId/notifications";
static String scanHistory(String projectId) =>
      "/points-plugin/projects/$projectId/scan-qr-history";

}