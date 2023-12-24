class SignUpRequestModel {
  String? phonenumber;
  String? password;
  String? username;
  String? email;

  SignUpRequestModel({
    this.phonenumber,
    this.password,
    this.username,
    this.email,
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
    return data;
  }
}
