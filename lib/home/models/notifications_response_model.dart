class NotificationsResponseModel {
  int? id;
  String? body;
  String? title;
  String? createdAt;
  int? user;
  String? username;

  NotificationsResponseModel(
      {this.id,
      this.body,
      this.title,
      this.createdAt,
      this.user,
      this.username});

  NotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    createdAt = json['created_at'];
    user = json['user'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    data['username'] = this.username;
    return data;
  }
}
