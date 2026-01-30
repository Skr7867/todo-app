import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/registerUser/user_register_repository.dart';
import '../../../repository/sendEmailOtp/send_email_otp_repository.dart';
import '../../../repository/verifyOtp/verify_otp_repository.dart';
import '../../../utils/utils.dart';
import '../../../res/routes/routes_name.dart';
import '../../../view/register/widget/register_user_dialog_box.dart';

class UserRegisterController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Repositories
  final SendEmailOtpRepository _sendOtpRepo = SendEmailOtpRepository();
  final VerifyOtpRepository _verifyOtpRepo = VerifyOtpRepository();
  final UserRegisterRepository _registerRepo = UserRegisterRepository();

  // UI States
  final isSendingOtp = false.obs;
  final isVerifyingOtp = false.obs;
  final isRegistering = false.obs;
  final isEmailVerified = false.obs;

  // OTP related
  final secretId = ''.obs;

  // ---------------- SEND OTP ----------------
  Future<void> sendEmailOtp(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Utils.snackBar('Please enter a valid email', 'Info');
      return;
    }

    try {
      isSendingOtp.value = true;

      final response = await _sendOtpRepo.sendEmailOtp({"email": email});

      isSendingOtp.value = false;

      debugPrint("📧 SEND OTP RESPONSE: $response");

      if (response['success'] == true) {
        secretId.value = response['data']['secretId'];
        Utils.toastMessageCenter('OTP sent to your email');
        _showOtpDialog(context);
      } else {
        Utils.snackBar(response['message'] ?? 'OTP failed', 'Error');
      }
    } catch (e) {
      isSendingOtp.value = false;
      Utils.snackBar(e.toString(), 'Error');
    }
  }

  // ---------------- VERIFY OTP ----------------
  Future<void> verifyOtp({
    required String otp,
    required BuildContext context,
  }) async {
    if (otp.length != 6) {
      Utils.snackBar('Please enter valid OTP', 'Info');
      return;
    }

    try {
      isVerifyingOtp.value = true;

      final response = await _verifyOtpRepo.verifyEmailOtp({
        "secretId": secretId.value,
        "otp": otp,
      });

      isVerifyingOtp.value = false;

      debugPrint("✅ VERIFY OTP RESPONSE: $response");

      if (response['success'] == true) {
        isEmailVerified.value = true;
        Navigator.pop(context);
        Utils.toastMessageCenter('Email verified successfully');
      } else {
        Utils.snackBar(response['message'] ?? 'Invalid OTP', 'Error');
      }
    } catch (e) {
      isVerifyingOtp.value = false;
      Utils.snackBar(e.toString(), 'Error');
    }
  }

  // ---------------- REGISTER USER ----------------
  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Utils.snackBar('All fields are required', 'Info');
      return;
    }

    if (!isEmailVerified.value) {
      Utils.snackBar('Please verify your email first', 'Info');
      return;
    }

    if (password != confirmPassword) {
      Utils.snackBar('Passwords do not match', 'Info');
      return;
    }

    try {
      isRegistering.value = true;

      final response = await _registerRepo.userRegister({
        "secretId": secretId.value,
        "name": name,
        "password": password,
        "confirmPassword": confirmPassword,
      });

      isRegistering.value = false;

      debugPrint("🧾 REGISTER RESPONSE: $response");

      if (response['success'] == true) {
        Utils.toastMessageCenter('Registration successful');
        Get.offAllNamed(RouteName.loginScreen);
      } else {
        Utils.snackBar(response['message'] ?? 'Registration failed', 'Error');
      }
    } catch (e) {
      isRegistering.value = false;
      Utils.snackBar(e.toString(), 'Error');
    }
  }

  // ---------------- OTP DIALOG ----------------
  void _showOtpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoginOtpDialogBox(),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
