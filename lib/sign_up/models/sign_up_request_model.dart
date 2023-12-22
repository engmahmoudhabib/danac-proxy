class SignUpRequestModel {
  String? phonenumber;
  String? password;
  String? username;

  SignUpRequestModel({
    this.phonenumber,
    this.password,
    this.username,
  });

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}
