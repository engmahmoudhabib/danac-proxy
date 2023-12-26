class LoginRequestModel {
  String? phonenumber;
  String? password;
  String? token;
  String? device;

  LoginRequestModel({
    this.phonenumber,
    this.password,
    this.device,
    this.token,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['username'];
    password = json['password'];
    token = json['token'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.phonenumber;
    data['password'] = this.password;
    data['token'] = this.token;
    data['device_type'] = this.device;
    return data;
  }
}
