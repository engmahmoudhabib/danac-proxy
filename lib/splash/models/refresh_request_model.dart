class RefreshTokenRequestModel {
  String? refresh;

  RefreshTokenRequestModel({this.refresh});

  RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    return data;
  }
}
