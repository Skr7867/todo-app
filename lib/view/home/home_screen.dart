import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/logOut/log_out_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final LogOutController controller = Get.put(LogOutController());
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for the main button
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Float animation for bells
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Fade in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Colors.purple.shade400,
                Colors.purple.shade600,
                Colors.pink.shade400,
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.notificationScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminder Hub',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Manage your reminders',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // See All Reminders Button
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: IconButton(
              tooltip: 'See All Reminders',
              onPressed: () {
                Get.toNamed(RouteName.reminderDetailsScreen);
                // Get.toNamed(RouteName.localReminderListScreen);
              },
              icon: const Icon(
                Icons.list_alt_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          // Logout Button
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.red.shade200.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: IconButton(
              tooltip: 'Logout',
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.blue.shade50,
              Colors.pink.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? size.width * 0.2 : 24,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // Animated floating bells decoration
                      _buildFloatingBells(),

                      SizedBox(height: isTablet ? 60 : 20),

                      // Main create button with pulse animation
                      _buildMainCreateButton(isTablet),

                      SizedBox(height: isTablet ? 40 : 30),

                      // Title text
                      _buildTitleText(isTablet),

                      SizedBox(height: isTablet ? 20 : 12),

                      // Subtitle text
                      _buildSubtitleText(isTablet),

                      SizedBox(height: isTablet ? 60 : 40),

                      // Feature cards
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingBells() {
    return SizedBox(
      height: 70,
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              /// Bell 1
              Positioned(
                left: 20 + _floatAnimation.value,
                top: 10,
                child: _buildBellIcon(
                  icon: Icons.notifications_active,
                  color: Colors.purple.shade300,
                  size: 20,
                ),
              ),

              /// Bell 2
              Positioned(
                right: 20 - _floatAnimation.value,
                top: 20,
                child: _buildBellIcon(
                  icon: Icons.alarm_add,
                  color: Colors.pink.shade300,
                  size: 20,
                ),
              ),

              /// Bell 3
              Positioned(
                left: 60 + (_floatAnimation.value * 0.5),
                bottom: 5,
                child: _buildBellIcon(
                  icon: Icons.access_alarm,
                  color: Colors.blue.shade300,
                  size: 24,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBellIcon({
    required IconData icon,
    required Color color,
    required double size,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double value, child) {
        return Transform.rotate(
          angle: value * 0.5,
          child: Icon(icon, size: size, color: color.withOpacity(0.6)),
        );
      },
    );
  }

  Widget _buildMainCreateButton(bool isTablet) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: GestureDetector(
            onTap: () => Get.toNamed(RouteName.createReminderScreen),
            child: Hero(
              tag: 'create_reminder',
              child: Container(
                width: isTablet ? 180 : 140,
                height: isTablet ? 180 : 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple.shade400,
                      Colors.purple.shade600,
                      Colors.pink.shade500,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade300.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    // onTap: () => Get.toNamed(RouteName.createReminderScreen),
                    onTap: () =>
                        Get.toNamed(RouteName.localReminderCreateScreen),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_alert_rounded,
                          size: isTablet ? 70 : 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 20 : 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleText(bool isTablet) {
    return Text(
      'Create Your Reminder',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isTablet ? 32 : 24,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.helveticaMedium,
        color: Colors.purple.shade900,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSubtitleText(bool isTablet) {
    return Text(
      'Never miss important moments again',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isTablet ? 18 : 14,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      // onPressed: () => Get.toNamed(RouteName.createReminderScreen),
      onPressed: () => Get.toNamed(RouteName.localReminderCreateScreen),
      backgroundColor: Colors.purple.shade600,
      elevation: 8,
      icon: const Icon(Icons.add_rounded, color: Colors.white),
      label: const Text(
        'New Reminder',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade100, Colors.red.shade50],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.red.shade600,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Message
              Text(
                'Are you sure you want to logout from your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
