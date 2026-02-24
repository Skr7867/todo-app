import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/round_button.dart';
import '../../res/customwidget/custome_textfield.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/register/user_register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controller = Get.put(UserRegisterController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final maxWidth = isTablet ? 500.0 : size.width * 0.9;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F3A28), Color(0xFF124734), Color(0xFF0A2017)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: 40,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// HEADER
                  _buildHeader(),

                  const SizedBox(height: 50),

                  /// FORM CARD
                  Center(
                    child: Container(
                      width: maxWidth,
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: _buildFormCard(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: const [
        Icon(Icons.person_add_rounded, size: 60, color: Colors.greenAccent),
        SizedBox(height: 20),
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Join us today and never miss a reminder',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 95, 71),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 25),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// EMAIL
          _buildFieldLabel('Email Address'),
          const SizedBox(height: 8),
          CustomTextField(
            fillColor: const Color.fromARGB(255, 121, 179, 123),
            borderColor: Colors.greenAccent,
            controller: controller.emailController,
            prefixIcon: Icons.email_outlined,
            hintText: 'your.email@example.com',
            suffixIcon: Padding(
              padding: const EdgeInsets.all(4),
              child: Obx(
                () => RoundButton(
                  buttonColor: controller.isEmailVerified.value
                      ? Colors.green
                      : Colors.greenAccent,
                  title: controller.isEmailVerified.value
                      ? 'Verified'
                      : 'Verify',
                  width: 90,
                  height: 40,
                  loading: controller.isSendingOtp.value,
                  onPress: controller.isEmailVerified.value
                      ? null
                      : () => controller.sendEmailOtp(context),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// NAME
          _buildFieldLabel('Full Name'),
          const SizedBox(height: 8),
          CustomTextField(
            fillColor: const Color.fromARGB(255, 121, 179, 123),
            borderColor: Colors.greenAccent,
            controller: controller.nameController,
            hintText: 'John Doe',
            prefixIcon: Icons.person_outline,
          ),

          const SizedBox(height: 15),

          /// PASSWORD
          _buildFieldLabel('Password'),
          const SizedBox(height: 8),
          CustomTextField(
            fillColor: const Color.fromARGB(255, 121, 179, 123),
            borderColor: Colors.greenAccent,
            controller: controller.passwordController,
            isPassword: true,
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline,
          ),

          const SizedBox(height: 15),

          /// CONFIRM PASSWORD
          _buildFieldLabel('Confirm Password'),
          const SizedBox(height: 8),
          CustomTextField(
            fillColor: const Color.fromARGB(255, 121, 179, 123),
            borderColor: Colors.greenAccent,
            controller: controller.confirmPasswordController,
            isPassword: true,
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline,
          ),

          const SizedBox(height: 25),

          /// REGISTER BUTTON
          Obx(
            () => Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E6F4C), Color(0xFF2FA36B)],
                ),
              ),
              child: RoundButton(
                buttonColor: Colors.transparent,
                title: 'Create Account',
                loading: controller.isRegistering.value,
                onPress: controller.registerUser,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// LOGIN LINK
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[300],
                  fontFamily: AppFonts.opensansRegular,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteName.loginScreen);
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    );
  }
}
