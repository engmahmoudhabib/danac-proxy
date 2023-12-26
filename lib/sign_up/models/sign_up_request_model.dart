class SignUpRequestModel {
  String? phonenumber;
  String? password;
  String? username;
  String? email;
  String? deviceToken;
  String? deviceType;
  String? x;
  String? y;

  SignUpRequestModel({
    this.phonenumber,
    this.password,
    this.username,
    this.email,
    this.deviceToken,
    this.deviceType,
    this.x,
    this.y,
  });

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    password = json['password'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    data['username'] = this.username;
    data['email'] = this.email;
    data['device_token'] = this.deviceToken;
    data['device_type'] = this.deviceType;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
