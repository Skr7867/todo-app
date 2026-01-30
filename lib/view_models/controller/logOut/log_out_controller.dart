import 'package:get/get.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../controller/user_preferences/user_preferences_viewmodel.dart';

class LogOutController extends GetxController {
  final UserPreferencesViewmodel _prefs = UserPreferencesViewmodel();

  Future<void> logout() async {
    await _prefs.removeUser();
    Utils.snackBar('Logged out successfully', 'Success');
    Get.offAllNamed(RouteName.loginScreen);
  }
}
