class LoginResponseModel {
  String? username;
  String? images;
  int? id;
  Tokens? tokens;

  LoginResponseModel({
    this.username,
    this.tokens,
    this.images,
    this.id,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    images = json['image'];
    id = json['id'];
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['image'] = this.images;
    data['id'] = this.id;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}
