import 'package:getxmvvm/data/network/network_api_services.dart';
import 'package:getxmvvm/models/home/user_list_model.dart';
import 'package:getxmvvm/res/api_url/api_urls.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<UserListModel> userListApi() async {
    dynamic response = await _apiService.getApi(ApiUrls.userListApi);
    return UserListModel.fromJson(response);
  }
}
