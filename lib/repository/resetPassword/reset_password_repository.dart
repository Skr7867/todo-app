import '../../data/network/network_api_services.dart';
import '../../res/api_url/api_urls.dart';

class ResetPasswordRepository {
  final _apiService = NetworkApiServices();

  Future<Map<String, dynamic>> resetPasswordApi(
    Map<String, dynamic> data,
  ) async {
    final response = await _apiService.postApi(data, ApiUrls.resetPasswordApi);

    return response;
  }
}
