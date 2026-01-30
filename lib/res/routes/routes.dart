import 'package:get/get.dart';
import 'package:getxmvvm/view/home/home_view.dart';
import 'package:getxmvvm/view/login/login_view.dart';
import 'package:getxmvvm/view/splash_screen.dart';

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
          name: RouteName.loginView,
          page: () => LoginView(),
          transitionDuration: Duration(microseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () => HomeView(),
          transitionDuration: Duration(microseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
