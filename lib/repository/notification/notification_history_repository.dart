import 'package:getxmvvm/data/network/network_api_services.dart';
import 'package:getxmvvm/models/notification/notification_history_model.dart';
import 'package:getxmvvm/res/api_url/api_urls.dart';

class NotificationHistoryRepository {
  final _apiService = NetworkApiServices();

  Future<NotificationHistoryModel> getNotification(String token) async {
    final response = await _apiService.getApi(
      ApiUrls.notificationHistoryApi,
      token: token,
    );

    return NotificationHistoryModel.fromJson(response);
  }
}
