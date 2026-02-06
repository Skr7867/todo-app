import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class VerifyOtpRepository {
  final _apiService = NetworkApiServices();

  Future<Map<String, dynamic>> verifyResetPasswordOtpApi(
    Map<String, dynamic> data,
  ) async {
    final response = await _apiService.postApi(
      data,
      ApiUrls.verifyResetPasswordOtpApi,
    );

    return response;
  }
}
