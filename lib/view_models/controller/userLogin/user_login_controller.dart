import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/userLogin/user_login_repository.dart';
import '../../../utils/utils.dart';
import '../../../res/routes/routes_name.dart';
import '../../../models/login/user_model.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class UserLoginController extends GetxController {
  /// 🔹 Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// 🔹 Repository
  final UserLoginRepository _loginRepo = UserLoginRepository();

  /// 🔹 Preferences
  final UserPreferencesViewmodel _prefs = UserPreferencesViewmodel();

  /// 🔹 UI State
  final isLoading = false.obs;

  /// ---------------- LOGIN ----------------
  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    /// 🔒 VALIDATION
    if (email.isEmpty) {
      Utils.snackBar('Email is required', 'Info');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Utils.snackBar('Please enter a valid email', 'Info');
      return;
    }

    if (password.isEmpty) {
      Utils.snackBar('Password is required', 'Info');
      return;
    }

    final payload = {"email": email, "password": password};

    log("🔐 LOGIN PAYLOAD: $payload");

    try {
      isLoading.value = true;

      final response = await _loginRepo.userLogin(payload);

      isLoading.value = false;

      log("✅ LOGIN RESPONSE: $response");

      if (response != null && response['success'] == true) {
        final String token = response['data']['token'];

        /// 🔐 SAVE TOKEN
        await _prefs.saveUser(UserModel(token: token));

        log("💾 TOKEN SAVED: $token");

        Utils.toastMessageCenter('Login successful');

        /// 🚀 NAVIGATE
        Get.offAllNamed(RouteName.homeScreen);
      } else {
        Utils.snackBar(
          response['message'] ?? 'Invalid email or password',
          'Error',
        );
      }
    } catch (e) {
      isLoading.value = false;
      Utils.snackBar(e.toString(), 'Error');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
