class SignUpResponseModel {
  InformationUser? informationUser;
  Tokens? tokens;

  SignUpResponseModel({this.informationUser, this.tokens});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    informationUser = json['information_user'] != null
        ? new InformationUser.fromJson(json['information_user'])
        : null;
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.informationUser != null) {
      data['information_user'] = this.informationUser!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class InformationUser {
  String? phonenumber;
  String? username;

  InformationUser({this.phonenumber, this.username});

  InformationUser.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    data['username'] = this.username;
    return data;
  }
}

class Tokens {
  String? refresh;
  String? accsess;

  Tokens({this.refresh, this.accsess});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    accsess = json['accsess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['accsess'] = this.accsess;
    return data;
  }
}
