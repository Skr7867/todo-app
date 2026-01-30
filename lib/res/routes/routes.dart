import 'package:get/get.dart';
import 'package:getxmvvm/view/login/user_login_screen.dart';
import 'package:getxmvvm/view/register/register_screen.dart';
import 'package:getxmvvm/view/splash_screen.dart';
import '../../view/home/home_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.registerScreen,
      page: () => RegisterScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),

    GetPage(
      name: RouteName.loginScreen,
      page: () => UserLoginScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => HomeScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
