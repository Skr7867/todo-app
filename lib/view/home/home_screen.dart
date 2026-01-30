import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/customwidget/custome_appbar.dart';
import 'package:getxmvvm/view_models/controller/logOut/log_out_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LogOutController controller = Get.put(LogOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home screen',
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Home Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  /// 🔹 CONFIRMATION DIALOG
  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
