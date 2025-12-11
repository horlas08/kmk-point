sealed class Endpoints {
  static const String login = "/points-plugin/login";
  static const String changePassword = "/points-plugin/participant/change-password";
  static const String updateProfile = "/points-plugin/update-profile";
  static const String requestResetOtp = "/points-plugin/password/request-otp";
  static const String verifyResetOtp = "/points-plugin/password/verify-otp";
  static const String resetPassword = "/points-plugin/password/reset";
  static String participantHomePage(String projectId) =>
      "/points-plugin/projects/$projectId/participant-home-page";
 static String getPointPageStat(String projectId) =>
      "points-plugin/projects/$projectId/participant-points-page";

}