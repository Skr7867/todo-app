import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/login/login_view_controller.dart';

class EmailTextInput extends StatelessWidget {
  EmailTextInput({super.key});
  final loginVm = Get.put(LoginViewController());
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginVm.emailController.value,
      focusNode: loginVm.emailFocusNode.value,
      validator: (value) {
        if (value!.isEmpty) {
          Utils.SnackBar('Email', 'Enter Your Email');
        }
        return null;
      },
      onFieldSubmitted: (value) {
        Utils.fieldFocusChanged(context, loginVm.emailFocusNode.value,
            loginVm.passwordFocusNode.value);
      },
      decoration: InputDecoration(
        hintText: 'email_hints'.tr,
      ),
    );
  }
}
