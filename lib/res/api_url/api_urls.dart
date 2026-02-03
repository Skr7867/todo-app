class ApiUrls {
  static const String baseUrl = 'https://reminder.meetmeall.com';

  static const String sendEmailOtpApi =
      '$baseUrl/apis/v1/auth/send-registration-otp';
  static const String verifyOtp = '$baseUrl/apis/v1/auth/verify-email-otp';
  static const String registerUserApi = '$baseUrl/apis/v1/auth/register';
  static const String userLoginApi = '$baseUrl/apis/v1/auth/login';
  static const String createReminderApi = '$baseUrl/apis/v1/reminders';
  static const String reminderDetailsApi = '$baseUrl/apis/v1/reminders';
  static const String deleteReminderApi = '$baseUrl/apis/v1/reminders';
}
