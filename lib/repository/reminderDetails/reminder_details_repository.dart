import '../../data/network/network_api_services.dart';
import '../../models/reminderDetails/reminder_details_model.dart';
import '../../res/api_url/api_urls.dart';

class ReminderDetailsRepository {
  final _apiService = NetworkApiServices();

  Future<ReminderDetailsModel> reminderDetailsApi(String token) async {
    final response = await _apiService.getApi(
      ApiUrls.reminderDetailsApi,
      token: token,
    );

    /// SAFETY CHECK
    if (response is! Map<String, dynamic>) {
      throw Exception("Server returned invalid response (Not JSON)");
    }

    return ReminderDetailsModel.fromJson(response);
  }
}
