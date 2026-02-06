import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/color/app_colors.dart';

class Utils {
  static void fieldFocusChanged(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.CENTER,
    );
  }

  static snackBar(String message, String title) {
    Color bgColor;

    switch (title.toLowerCase()) {
      case 'error':
        bgColor = Colors.red;
        break;
      case 'failed':
        bgColor = Colors.red;
        break;
      case 'success':
        bgColor = Colors.green;
        break;
      case 'info':
        bgColor = AppColors.blueColor;
        break;
      default:
        bgColor = AppColors.blueColor;
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
      borderRadius: 8,
    );
  }
}
