// import 'package:get/get.dart';
// import 'package:getxmvvm/models/home/user_list_model.dart';
// import '../../../data/response/status.dart';
// class HomeViewController extends GetxController {
//   final _api = HomeRepository();
//   final rxRequestStatus = Status.LOADING.obs;
//   final userList = UserListModel().obs;
//   RxString error = ''.obs;
//   void setError(String _value) => error.value = _value;
//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//   void setUserList(UserListModel _value) => userList.value = _value;
//   void userListApi() {
//     // setRxRequestStatus(Status.LOADING);
//     _api.userListApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setUserList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }

//   void refreshApi() {
//     setRxRequestStatus(Status.LOADING);
//     _api.userListApi().then((value) {
//       setRxRequestStatus(Status.COMPLETED);
//       setUserList(value);
//     }).onError((error, stackTrace) {
//       setError(error.toString());
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
// }
