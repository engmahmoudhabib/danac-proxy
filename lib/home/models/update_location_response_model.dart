class UpdateLocarionResponseModel {
  String? message;
  double? longitude;
  double? latitude;

  UpdateLocarionResponseModel({this.message, this.longitude, this.latitude});

  UpdateLocarionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
