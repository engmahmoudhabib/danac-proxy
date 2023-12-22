class ClientsResponseModel {
  int? id;
  String? name;
  String? address;
  String? phonenumber;
  String? category;
  String? notes;
  String? location;
  int? totalPoints;

  ClientsResponseModel(
      {this.id,
      this.name,
      this.address,
      this.phonenumber,
      this.category,
      this.notes,
      this.location,
      this.totalPoints});

  ClientsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    category = json['category'];
    notes = json['notes'];
    location = json['location'];
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['category'] = this.category;
    data['notes'] = this.notes;
    data['location'] = this.location;
    data['total_points'] = this.totalPoints;
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
