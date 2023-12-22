class SuppliersResponseModel {
  int? id;
  String? name;
  String? companyName;
  String? address;
  String? phoneNumber;
  String? info;

  SuppliersResponseModel({
    this.id,
    this.name,
    this.companyName,
    this.address,
    this.phoneNumber,
    this.info,
  });

  SuppliersResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['info'] = this.info;
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
