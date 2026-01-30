import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/models/login/user_model.dart';
import 'package:getxmvvm/repository/login_repository/login_repository.dart';
import 'package:getxmvvm/res/routes/routes_name.dart';
import 'package:getxmvvm/utils/utils.dart';
import 'package:getxmvvm/view_models/controller/user_preferences/user_preferences_viewmodel.dart';

class LoginViewController extends GetxController {
  final _api = LoginRepository();

  UserPreferencesViewmodel userPreferencesViewmodel =
      UserPreferencesViewmodel();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      if (value['Error'] == 'user not found') {
        Utils.SnackBar('Login', value['Error']);
      } else {
        userPreferencesViewmodel
            .saveUser(UserModel.fromJson(value))
            .then((value) {
          Get.delete<LoginViewController>();
          Get.toNamed(RouteName.homeView);
        }).onError((error, stackTrace) {});
      }
      Utils.SnackBar('Login', 'Login Successfully');
    }).onError(
      (error, stackTrace) {
        log(error.toString());
        loading.value = false;
        Utils.SnackBar('Error', error.toString());
      },
    );
  }
}
