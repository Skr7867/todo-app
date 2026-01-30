import 'dart:async';
import 'package:get/get.dart';
import 'package:getxmvvm/res/routes/routes_name.dart';
import 'package:getxmvvm/view_models/controller/user_preferences/user_preferences_viewmodel.dart';

class SplashServices {
  final UserPreferencesViewmodel _prefs = UserPreferencesViewmodel();

  Future<void> checkLoginStatus() async {
    try {
      final user = await _prefs.getUser();
      final String? token = user.token;

      Timer(const Duration(seconds: 3), () {
        if (token != null && token.isNotEmpty) {
          Get.offAllNamed(RouteName.homeScreen);
        } else {
          Get.offAllNamed(RouteName.loginScreen);
        }
      });
    } catch (e) {
      Timer(const Duration(seconds: 3), () {
        Get.offAllNamed(RouteName.loginScreen);
      });
    }
  }
}
