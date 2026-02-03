import 'package:timezone/data/latest.dart' as tz_data;

class TimezoneService {
  static Future init() async {
    // Already initialized in NotificationService, but keep for safety
    tz_data.initializeTimeZones();
    // You can set your local location if needed
    // tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  }
}
