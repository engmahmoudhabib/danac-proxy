class PointsResponseModel {
  int? id;
  double? number;
  String? expireDate;
  String? date;
  bool? isUsed;
  int? client;

  PointsResponseModel(
      {this.id,
      this.number,
      this.expireDate,
      this.date,
      this.isUsed,
      this.client});

  PointsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = double.parse(json['number'].toString());
    expireDate = json['expire_date'];
    date = json['date'];
    isUsed = json['is_used'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['expire_date'] = this.expireDate;
    data['date'] = this.date;
    data['is_used'] = this.isUsed;
    data['client'] = this.client;
    return data;
  }
}
