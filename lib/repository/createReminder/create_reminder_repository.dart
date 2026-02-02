import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class CreateReminderRepository {
  final _apiServices = NetworkApiServices();
  Future<dynamic> createReminderApi(
    Map<String, dynamic> data,
    String token,
  ) async {
    return await _apiServices.postApi(
      data,
      ApiUrls.createReminderApi,
      token: token,
    );
  }
}
