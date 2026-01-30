import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../res/color/app_colors.dart';
import '../../res/components/round_button.dart';
import '../../res/customwidget/custome_textfield.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/register/user_register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(UserRegisterController());
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _circleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _circleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final maxWidth = isTablet ? 500.0 : size.width * 0.9;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Main Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),

                          // Header Section
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildHeader(),
                          ),

                          const SizedBox(height: 40),

                          // Form Container
                          SlideTransition(
                            position: _slideAnimation,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Center(
                                child: Container(
                                  width: maxWidth,
                                  constraints: const BoxConstraints(
                                    maxWidth: 500,
                                  ),
                                  child: _buildFormCard(context),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _circleController,
      builder: (context, child) {
        return Stack(
          children: [
            // Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF8B5CF6),
                    const Color(0xFFA855F7),
                  ],
                ),
              ),
            ),

            // Animated Circles
            Positioned(
              top:
                  -100 + (math.sin(_circleController.value * 2 * math.pi) * 20),
              right: -100,
              child: _buildDecorativeCircle(300, Colors.white.withOpacity(0.1)),
            ),
            Positioned(
              top: 100 + (math.cos(_circleController.value * 2 * math.pi) * 30),
              left: -50,
              child: _buildDecorativeCircle(
                200,
                Colors.white.withOpacity(0.08),
              ),
            ),
            Positioned(
              bottom:
                  -80 +
                  (math.sin(_circleController.value * 2 * math.pi + 1) * 25),
              left: 50,
              child: _buildDecorativeCircle(
                250,
                Colors.white.withOpacity(0.06),
              ),
            ),
            Positioned(
              bottom:
                  150 +
                  (math.cos(_circleController.value * 2 * math.pi + 2) * 15),
              right: 20,
              child: _buildDecorativeCircle(
                150,
                Colors.white.withOpacity(0.09),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.05)],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDecorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo/Icon
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          ),
          child: const Icon(
            Icons.person_add_rounded,
            size: 50,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 14),

        // Title
        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 3),

        // Subtitle
        Text(
          'Join us today and never miss a reminder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email Field
              _buildAnimatedField(
                delay: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Email Address'),
                    const SizedBox(height: 8),
                    CustomTextField(
                      borderColor: Colors.purpleAccent,
                      controller: controller.emailController,
                      prefixIcon: Icons.email_outlined,
                      hintText: 'your.email@example.com',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Obx(
                          () => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: RoundButton(
                              buttonColor: controller.isEmailVerified.value
                                  ? Colors.green
                                  : AppColors.blueColor,
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
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Name Field
              _buildAnimatedField(
                delay: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    CustomTextField(
                      borderColor: Colors.purpleAccent,
                      controller: controller.nameController,
                      hintText: 'John Doe',
                      prefixIcon: Icons.person_outline,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Password Field
              _buildAnimatedField(
                delay: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Password'),
                    const SizedBox(height: 8),
                    CustomTextField(
                      borderColor: Colors.purpleAccent,
                      controller: controller.passwordController,
                      isPassword: true,
                      hintText: '••••••••',
                      prefixIcon: Icons.lock_outline,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Confirm Password Field
              _buildAnimatedField(
                delay: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Confirm Password'),
                    const SizedBox(height: 8),
                    CustomTextField(
                      borderColor: Colors.purpleAccent,
                      controller: controller.confirmPasswordController,
                      isPassword: true,
                      hintText: '••••••••',
                      prefixIcon: Icons.lock_outline,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Register Button
              _buildAnimatedField(
                delay: 600,
                child: Obx(
                  () => Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B5CF6).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: RoundButton(
                      buttonColor: Colors.transparent,
                      title: 'Create Account',
                      loading: controller.isRegistering.value,
                      onPress: controller.registerUser,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login Link
              _buildAnimatedField(
                delay: 700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
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
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildAnimatedField({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}
