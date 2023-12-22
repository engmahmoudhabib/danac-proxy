class ClientsRequestModel {
  String? name;
  String? address;
  String? phonenumber;
  String? category;
  String? notes;

  ClientsRequestModel(
      {this.name, this.address, this.phonenumber, this.category, this.notes});

  ClientsRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    category = json['category'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['category'] = this.category;
    data['notes'] = this.notes;
    return data;
  }
}
