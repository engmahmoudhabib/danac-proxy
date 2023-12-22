class SuppliersRequestModel {
  String? name;
  String? companyName;
  String? phoneNumber;
  String? info;
  String? address;

  SuppliersRequestModel(
      {this.name, this.companyName, this.phoneNumber, this.info, this.address});

  SuppliersRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    companyName = json['company_name'];
    phoneNumber = json['phone_number'];
    info = json['info'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['phone_number'] = this.phoneNumber;
    data['info'] = this.info;
    data['address'] = this.address;
    return data;
  }
}
