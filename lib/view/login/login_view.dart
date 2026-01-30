import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/view/login/widget/button.dart';
import 'package:getxmvvm/view/login/widget/email_text_input.dart';
import 'package:getxmvvm/view/login/widget/password_text_input.dart';
import 'package:getxmvvm/view_models/controller/login/login_view_controller.dart';
import '../../res/color/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVm = Get.put(LoginViewController());
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<LoginViewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [EmailTextInput()],
              ),
            ),
            SizedBox(height: 30),
            PasswordTextInput(),
            SizedBox(height: 30),
            Button(fromkey: _formkey)
          ],
        ),
      ),
    );
  }
}
