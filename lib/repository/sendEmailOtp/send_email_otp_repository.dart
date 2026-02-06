import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class SendEmailOtpRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> sendEmailOtp(var data) async {
    dynamic response = await _apiService.postApi(data, ApiUrls.sendEmailOtpApi);
    return response;
  }
}
