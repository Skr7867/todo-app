import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/routes/routes_name.dart';

import '../../res/customwidget/custome_appbar.dart';
import '../../view_models/controller/notification/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  /// ⭐ INIT CONTROLLER
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications',
        automaticallyImplyLeading: true,
      ),

      /// ⭐ REACTIVE BODY
      body: Obx(() {
        /// ================= LOADING =================
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ================= ERROR =================
        if (controller.errorMessage.isNotEmpty) {
          return _ErrorView(
            message: controller.errorMessage.value,
            onRetry: controller.fetchNotifications,
          );
        }

        /// ================= EMPTY =================
        if (controller.notificationsList.isEmpty) {
          return const _EmptyView();
        }

        /// ================= LIST =================
        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notificationsList.length,
            itemBuilder: (_, index) {
              final notification = controller.notificationsList[index];

              return _NotificationTile(notification: notification);
            },
          ),
        );
      }),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final dynamic notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.reminderDetailsScreen);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8),
          ],
        ),

        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications, color: Colors.deepPurple),
            ),

            const SizedBox(width: 14),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? "Notification",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    notification.message ?? "",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey.shade400),

          const SizedBox(height: 12),

          const Text(
            "No Notifications",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 70, color: Colors.red.shade300),

            const SizedBox(height: 16),

            Text(message, textAlign: TextAlign.center),

            const SizedBox(height: 16),

            ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
