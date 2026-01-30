import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/color/app_colors.dart';
import 'package:getxmvvm/res/components/general_exception.dart';
import 'package:getxmvvm/res/components/internet_exception_widget.dart';
import 'package:getxmvvm/view_models/controller/home/home_view_controller.dart';
import 'package:getxmvvm/view_models/controller/user_preferences/user_preferences_viewmodel.dart';

import '../../data/response/status.dart';
import '../../res/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeViewController());
  UserPreferencesViewmodel userPreferencesViewmodel =
      UserPreferencesViewmodel();

  @override
  void initState() {
    super.initState();
    homeController.userListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        actions: [
          IconButton(
              onPressed: () {
                userPreferencesViewmodel.removeUser().then((value) {
                  Get.toNamed(RouteName.loginView);
                });
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Obx(
        () {
          switch (homeController.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (homeController.error.value ==
                  'No Internet Please turn on Internet') {
                return InternetExceptionWidget(onpress: () {
                  homeController.refreshApi();
                });
              } else {
                return GeneralException(
                  onpress: () {
                    homeController.refreshApi();
                  },
                );
              }
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: homeController.userList.value.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(homeController
                            .userList.value.data![index].avatar
                            .toString()),
                      ),
                      title: Text(homeController
                          .userList.value.data![index].firstName
                          .toString()),
                      subtitle: Text(homeController
                          .userList.value.data![index].email
                          .toString()),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
