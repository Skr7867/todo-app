import 'package:getxmvvm/data/network/network_api_services.dart';
import 'package:getxmvvm/res/api_url/api_urls.dart';

class VerifyOtpRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> verifyEmailOtp(var data) async {
    dynamic response = await _apiService.postApi(data, ApiUrls.verifyOtp);
    return response;
  }
}
