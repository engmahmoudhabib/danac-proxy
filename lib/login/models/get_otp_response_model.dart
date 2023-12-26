class GetOTPResponseModel {
  String? message;
  int? userId;

  GetOTPResponseModel({this.message, this.userId});

  GetOTPResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    return data;
  }
}
