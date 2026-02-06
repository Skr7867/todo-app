import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class UserRegisterRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> userRegister(var data) async {
    dynamic response = await _apiService.postApi(data, ApiUrls.registerUserApi);
    return response;
  }
}
