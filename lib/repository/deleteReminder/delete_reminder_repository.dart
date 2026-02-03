import 'package:getxmvvm/data/network/network_api_services.dart';
import 'package:getxmvvm/res/api_url/api_urls.dart';

class DeleteReminderRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> deleteReminder(String reminderId, String token) async {
    final url = '${ApiUrls.deleteReminderApi}/$reminderId';
    return await _apiService.deleteApi(url, token: token);
  }
}
