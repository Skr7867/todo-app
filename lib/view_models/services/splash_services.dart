// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:getxmvvm/res/routes/routes_name.dart';
// import 'package:getxmvvm/view_models/controller/user_preferences/user_preferences_viewmodel.dart';

// class SplashServices {
//   UserPreferencesViewmodel userPreferencesViewmodel =
//       UserPreferencesViewmodel();

//   void isLogin() {
//     userPreferencesViewmodel.getUser().then((value) {
//       print(value.token);
//       if (value.token!.isEmpty || value.token.toString() == 'null') {
//         Timer(
//           const Duration(seconds: 3),
//           () => Get.toNamed(RouteName.loginView),
//         );
//       } else {
//         Timer(
//             const Duration(seconds: 3), () => Get.toNamed(RouteName.homeView));
//       }
//     });
//   }
// }

import 'dart:async';
import 'package:get/get.dart';
import 'package:getxmvvm/res/routes/routes_name.dart';
import 'package:getxmvvm/view_models/controller/user_preferences/user_preferences_viewmodel.dart';

class SplashServices {
  UserPreferencesViewmodel userPreferencesViewmodel =
      UserPreferencesViewmodel();

  void isLogin() {
    userPreferencesViewmodel.getUser().then((value) {
      // Null safety check before accessing token
      String? token = value.token;

      if (token == null || token.isEmpty || token.toString() == 'null') {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(RouteName.homeView),
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(RouteName.homeView),
        );
      }
    }).catchError((error) {
      // Handle potential errors gracefully
      print("Error fetching user: $error");
      Timer(
        const Duration(seconds: 3),
        () => Get.toNamed(RouteName.loginView),
      );
    });
  }
}
