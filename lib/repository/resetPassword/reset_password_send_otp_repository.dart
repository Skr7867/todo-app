import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class ResetPasswordSendOtpRepository {
  final _apiService = NetworkApiServices();

  Future<Map<String, dynamic>> sendResetPasswordEmailOtp(
    Map<String, dynamic> data,
  ) async {
    final response = await _apiService.postApi(
      data,
      ApiUrls.resetPasswordOtpApi,
    );

    return response;
  }
}
