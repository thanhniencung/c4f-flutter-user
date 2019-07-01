class User {
  UserData data;

  User({this.data});

  factory User.fromJson(Map<String, dynamic> json) {
    // json['data'] <=> map
    return User(data: UserData.fromJson(json['data']));
  }
}

class UserData {
  String displayName;
  String avatar;
  String phone;
  String token;

  UserData({this.displayName, this.avatar, this.phone, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      displayName: json['displayName'],
      avatar: json['avatar'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}
