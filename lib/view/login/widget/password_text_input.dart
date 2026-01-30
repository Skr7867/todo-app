import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getxmvvm/view_models/controller/login/login_view_controller.dart';

import '../../../utils/utils.dart';

class PasswordTextInput extends StatelessWidget {
  PasswordTextInput({super.key});
  final loginVm = Get.put(LoginViewController());
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginVm.passwordController.value,
      focusNode: loginVm.passwordFocusNode.value,
      validator: (value) {
        if (value!.isEmpty) {
          Utils.SnackBar('Password', 'Please Enter Your Password');
        }
        return null;
      },
      onFieldSubmitted: (value) {},
      decoration: InputDecoration(
        hintText: 'password_hints'.tr,
      ),
    );
  }
}
