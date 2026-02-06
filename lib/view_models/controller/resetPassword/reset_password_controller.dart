import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/resetPassword/reset_password_repository.dart';
import '../../../repository/resetPassword/reset_password_send_otp_repository.dart';
import '../../../repository/resetPassword/verify_otp_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class ResetPasswordController extends GetxController {
  /// ================= REPOSITORIES =================
  final _sendOtpRepo = ResetPasswordSendOtpRepository();
  final _verifyOtpRepo = VerifyOtpRepository();
  final _resetRepo = ResetPasswordRepository();

  /// ================= TEXT CONTROLLERS =================
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// ================= SEPARATE LOADING STATES =================
  RxBool isSendingOtp = false.obs;
  RxBool isVerifyingOtp = false.obs;
  RxBool isResettingPassword = false.obs;

  /// ================= STATE =================
  RxBool isOtpSent = false.obs;
  RxBool isOtpVerified = false.obs;
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  RxString secretId = "".obs;

  /// ================= VALIDATION =================
  RxBool get canSendOtp => RxBool(
    emailController.text.trim().isNotEmpty &&
        GetUtils.isEmail(emailController.text.trim()),
  );

  RxBool get canVerifyOtp =>
      RxBool(isOtpSent.value && otpController.text.trim().length >= 4);

  RxBool get canResetPassword => RxBool(
    isOtpVerified.value &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text.length >= 6,
  );

  /// =================================================
  /// SEND OTP
  /// =================================================
  Future sendOtp() async {
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Utils.snackBar("Please enter a valid email", "Error");
      return;
    }

    try {
      isSendingOtp.value = true;

      final response = await _sendOtpRepo.sendResetPasswordEmailOtp({
        "email": emailController.text.trim(),
      });

      if (response["success"] == true) {
        secretId.value = response["data"]["secretId"];
        isOtpSent.value = true;

        Utils.snackBar("OTP sent to your email successfully", "Success");
        log("SecretId => ${secretId.value}");
      }
    } catch (e) {
      Utils.snackBar(e.toString(), "Error");
      log("Send OTP Error: $e");
    } finally {
      isSendingOtp.value = false;
    }
  }

  /// =================================================
  /// VERIFY OTP
  /// =================================================
  Future verifyOtp() async {
    if (otpController.text.trim().isEmpty) {
      Utils.snackBar("Please enter OTP", "Error");
      return;
    }

    try {
      isVerifyingOtp.value = true;

      final response = await _verifyOtpRepo.verifyResetPasswordOtpApi({
        "secretId": secretId.value,
        "otp": otpController.text.trim(),
      });

      if (response["success"] == true) {
        isOtpVerified.value = true;
        Utils.snackBar("OTP verified successfully", "Success");
      }
    } catch (e) {
      Utils.snackBar(e.toString(), "Error");
      log("Verify OTP Error: $e");
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  /// =================================================
  /// RESET PASSWORD
  /// =================================================
  Future resetPassword() async {
    // Validation
    if (newPasswordController.text.trim().length < 6) {
      Utils.snackBar("Password must be at least 6 characters", "Error");
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Utils.snackBar("Passwords do not match", "Error");
      return;
    }

    try {
      isResettingPassword.value = true;

      final response = await _resetRepo.resetPasswordApi({
        "secretId": secretId.value,
        "newPassword": newPasswordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
      });

      if (response["success"] == true) {
        Utils.snackBar("Password reset successful!", "Success");

        // Clear all fields
        emailController.clear();
        otpController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Reset states
        isOtpSent.value = false;
        isOtpVerified.value = false;
        secretId.value = "";

        // Navigate to login after a short delay
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAllNamed(RouteName.loginScreen);
      }
    } catch (e) {
      Utils.snackBar(e.toString(), "Error");
      log("Reset Password Error: $e");
    } finally {
      isResettingPassword.value = false;
    }
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
