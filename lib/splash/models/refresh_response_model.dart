class RefreshTokenResponseModel {
  String? access;
  String? refresh;

  RefreshTokenResponseModel({
    this.access,
    this.refresh,
  });

  RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.access;
    data['refresh'] = this.refresh;
    return data;
  }
}
