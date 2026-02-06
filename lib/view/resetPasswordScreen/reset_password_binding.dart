import 'package:get/get.dart';

import '../../view_models/controller/resetPassword/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
      fenix: true,
    );
  }
}
