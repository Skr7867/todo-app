import 'package:flutter/material.dart';

import '../res/fonts/app_fonts.dart';
import '../view_models/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _splashServices.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome Back',
          style: TextStyle(fontSize: 18, fontFamily: AppFonts.opensansRegular),
        ),
      ),
    );
  }
}
