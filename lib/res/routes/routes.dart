import 'package:get/get.dart';
import 'package:getxmvvm/view/localReminder/local_reminder_create_screen.dart';
import 'package:getxmvvm/view/login/user_login_screen.dart';
import 'package:getxmvvm/view/register/register_screen.dart';
import 'package:getxmvvm/view/reminderDetails/reminder_details_screen.dart';
import 'package:getxmvvm/view/splash_screen.dart';
import '../../view/alarmScreen/alarm_screen.dart';
import '../../view/home/home_screen.dart';
import '../../view/localReminder/local_reminder_list_screen.dart';
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
    // GetPage(
    //   name: RouteName.createReminderScreen,
    //   page: () => CreateReminderScreen(),
    //   transitionDuration: Duration(microseconds: 250),
    //   transition: Transition.leftToRightWithFade,
    // ),
    GetPage(
      name: RouteName.reminderDetailsScreen,
      page: () => ReminderDetailsScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.localReminderCreateScreen,
      page: () => LocalReminderCreateScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.localReminderListScreen,
      page: () => LocalReminderListScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.alarmScreen,
      page: () => AlarmScreen(),
      transitionDuration: Duration(microseconds: 250),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
