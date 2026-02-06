import 'package:get/get.dart';

import '../../view_models/controller/userLogin/user_login_controller.dart';

class UserLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserLoginController>(
      () => UserLoginController(),
      fenix: true, // Recreates controller when accessed after disposal
    );
  }
}
