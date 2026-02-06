import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_models/controller/resetPassword/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final controller = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER SECTION
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Don\'t worry! It happens. Please enter your email to reset your password.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              /// STEP 1: EMAIL
              Obx(
                () => _buildStepCard(
                  stepNumber: 1,
                  title: 'Enter Email',
                  isCompleted: controller.isOtpSent.value,
                  isActive: true,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: controller.emailController,
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !controller.isOtpSent.value,
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        label: controller.isOtpSent.value
                            ? 'OTP Sent ✓'
                            : 'Send OTP',
                        isLoading: controller.isSendingOtp.value,
                        isCompleted: controller.isOtpSent.value,
                        onPressed: controller.isOtpSent.value
                            ? null
                            : controller.sendOtp,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// STEP 2: VERIFY OTP
              Obx(
                () => _buildStepCard(
                  stepNumber: 2,
                  title: 'Verify OTP',
                  isCompleted: controller.isOtpVerified.value,
                  isActive: controller.isOtpSent.value,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: controller.otpController,
                        hint: 'Enter 6-digit OTP',
                        icon: Icons.pin_outlined,
                        keyboardType: TextInputType.number,
                        enabled:
                            controller.isOtpSent.value &&
                            !controller.isOtpVerified.value,
                        maxLength: 6,
                      ),
                      const SizedBox(height: 12),
                      _buildActionButton(
                        label: controller.isOtpVerified.value
                            ? 'Verified ✓'
                            : 'Verify OTP',
                        isLoading: controller.isVerifyingOtp.value,
                        isCompleted: controller.isOtpVerified.value,
                        onPressed:
                            controller.isOtpVerified.value ||
                                !controller.isOtpSent.value
                            ? null
                            : controller.verifyOtp,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// STEP 3: NEW PASSWORD
              Obx(
                () => _buildStepCard(
                  stepNumber: 3,
                  title: 'Create New Password',
                  isCompleted: false,
                  isActive: controller.isOtpVerified.value,
                  child: Column(
                    children: [
                      _buildPasswordField(
                        controller: controller.newPasswordController,
                        hint: 'New password (min 6 characters)',
                        isObscure: !controller.showPassword.value,
                        onToggle: controller.togglePasswordVisibility,
                        enabled: controller.isOtpVerified.value,
                      ),
                      const SizedBox(height: 12),
                      _buildPasswordField(
                        controller: controller.confirmPasswordController,
                        hint: 'Confirm new password',
                        isObscure: !controller.showConfirmPassword.value,
                        onToggle: controller.toggleConfirmPasswordVisibility,
                        enabled: controller.isOtpVerified.value,
                      ),
                      const SizedBox(height: 20),
                      _buildResetButton(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// STEP CARD
  Widget _buildStepCard({
    required int stepNumber,
    required String title,
    required bool isCompleted,
    required bool isActive,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? Colors.green.shade300
              : isActive
              ? Colors.deepPurple.shade200
              : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// STEP HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.shade50
                  : isActive
                  ? Colors.deepPurple.shade50
                  : Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green
                        : isActive
                        ? Colors.deepPurple
                        : Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : Text(
                            '$stepNumber',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.black87 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          /// STEP CONTENT
          Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }

  /// TEXT FIELD
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool enabled = true,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
        ),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: TextStyle(
          fontSize: 15,
          color: enabled ? Colors.black87 : Colors.grey.shade400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(
            icon,
            color: enabled ? Colors.deepPurple.shade300 : Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          counterText: '',
        ),
      ),
    );
  }

  /// PASSWORD FIELD
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isObscure,
    required VoidCallback onToggle,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
        ),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: isObscure,
        style: TextStyle(
          fontSize: 15,
          color: enabled ? Colors.black87 : Colors.grey.shade400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: enabled ? Colors.deepPurple.shade300 : Colors.grey.shade400,
          ),
          suffixIcon: enabled
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: onToggle,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// ACTION BUTTON (Send OTP / Verify)
  Widget _buildActionButton({
    required String label,
    required bool isLoading,
    required bool isCompleted,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading || isCompleted ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isCompleted
              ? Colors.green
              : isLoading
              ? Colors.grey.shade400
              : Colors.deepPurple,
          disabledBackgroundColor: isCompleted
              ? Colors.green
              : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isCompleted ? 0 : 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  /// RESET PASSWORD BUTTON
  Widget _buildResetButton() {
    return Obx(() {
      final canReset = controller.canResetPassword.value;
      final isLoading = controller.isResettingPassword.value;

      return Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: canReset && !isLoading
              ? LinearGradient(
                  colors: [
                    Colors.deepPurple.shade400,
                    Colors.deepPurple.shade700,
                  ],
                )
              : null,
          color: !canReset || isLoading ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(14),
          boxShadow: canReset && !isLoading
              ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: canReset && !isLoading ? controller.resetPassword : null,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
