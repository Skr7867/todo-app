import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/login/user_model.dart';

class UserPreferencesViewmodel {
  static const _tokenKey = 'token';

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(_tokenKey, user.token ?? '');
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString(_tokenKey);
    return UserModel(token: token);
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
