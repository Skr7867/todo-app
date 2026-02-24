import 'package:get/get.dart';

import '../../view/alarmScreen/alarm_screen.dart';
import '../../view/home/timeline_screen.dart';
import '../../view/localReminder/add_new_event_screen.dart';
import '../../view/login/user_login_binding.dart';
import '../../view/login/user_login_screen.dart';
import '../../view/notification/notification_screen.dart';
import '../../view/register/register_screen.dart';

import '../../view/resetPasswordScreen/reset_password_binding.dart';
import '../../view/resetPasswordScreen/reset_password_screen.dart';
import '../../view/splash_screen.dart';
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
      page: () => const UserLoginScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
      binding: UserLoginBinding(),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => TimelineScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.notificationScreen,
      page: () => NotificationScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),

    GetPage(
      name: RouteName.localReminderCreateScreen,
      page: () => AddNewEventScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: RouteName.alarmScreen,
      page: () => AlarmScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
