import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../res/api_url/api_urls.dart';

class FCMRepository {
  Future<void> registerToken({
    required String fcmToken,
    required String authToken,
  }) async {
    try {
      final url = Uri.parse('${ApiUrls.baseUrl}/apis/v1/fcm/token');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({"fcmToken": fcmToken}),
      );

      if (response.statusCode == 200) {
        log("✅ FCM Token Registered");
      } else {
        log("❌ FCM Register Failed => ${response.body}");
      }
    } catch (e) {
      log("❌ FCM Register Error => $e");
    }
  }
}
