import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/round_button.dart';
import '../../res/customwidget/custome_textfield.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/userLogin/user_login_controller.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  UserLoginController get controller => Get.find<UserLoginController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final maxWidth = isTablet ? 500.0 : size.width * 0.9;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
        Icon(Icons.lock_person_rounded, size: 60, color: Colors.greenAccent),
        SizedBox(height: 20),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to continue to your account',
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
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 25,
            // offset: const Offset(4, 4),
          ),
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
            borderColor: Colors.greenAccent,
            controller: controller.emailController,
            hintText: 'your.email@example.com',
            prefixIcon: Icons.email_outlined,
            fillColor: const Color.fromARGB(255, 121, 179, 123),
          ),

          const SizedBox(height: 20),

          /// PASSWORD
          _buildFieldLabel('Password'),
          const SizedBox(height: 8),
          CustomTextField(
            borderColor: Colors.greenAccent,
            controller: controller.passwordController,
            isPassword: true,
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline,
            fillColor: const Color.fromARGB(255, 121, 179, 123),
          ),

          const SizedBox(height: 12),

          /// FORGOT PASSWORD
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.toNamed(RouteName.resetPasswordScreen);
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// LOGIN BUTTON
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
                title: 'Sign In',
                loading: controller.isLoading.value,
                onPress: controller.loginUser,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// REGISTER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[300],
                  fontFamily: AppFonts.opensansRegular,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteName.registerScreen);
                },
                child: const Text(
                  'Sign Up',
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
