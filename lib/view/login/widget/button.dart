import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/view_models/controller/login/login_view_controller.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/components/round_button.dart';

class Button extends StatelessWidget {
  final fromkey;
  Button({super.key, required this.fromkey});
  final loginVm = Get.put(LoginViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RoundButton(
        loading: loginVm.loading.value,
        width: 200,
        title: 'Login',
        onPress: () {
          if (fromkey.currentState!.validate()) {
            loginVm.loginApi();
          }
        },
        buttonColor: AppColors.blueColor,
      ),
    );
  }
}
