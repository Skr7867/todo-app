class UserModel {
  String? token;

  UserModel({this.token});

  UserModel.fromJson(Map<String, String> json) {
    token = json['token'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['token'] = token.toString();
    return data;
  }
}
