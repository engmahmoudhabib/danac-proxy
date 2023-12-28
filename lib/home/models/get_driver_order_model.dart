class GetDriverOrderResponseModel {
  Receipt? receipt;
  List<int>? products;
  bool? isDelivered;

  GetDriverOrderResponseModel({this.receipt, this.products, this.isDelivered});

  GetDriverOrderResponseModel.fromJson(Map<String, dynamic> json) {
    receipt =
        json['receipt'] != null ? new Receipt.fromJson(json['receipt']) : null;
    products = json['products'].cast<int>();
    isDelivered = json['is_delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receipt != null) {
      data['receipt'] = this.receipt!.toJson();
    }
    data['products'] = this.products;
    data['is_delivered'] = this.isDelivered;
    return data;
  }
}

class Receipt {
  int? id;
  int? verifyCode;
  String? phonenumber;
  double? recivePyement;
  double? discount;
  double? reclaimedProducts;
  double? previousDepts;
  double? remainingAmount;
  String? date;
  String? barcode;
  String? location;
  bool? delivered;
  int? client;
  int? employee;
  List<int>? products;

  Receipt(
      {this.id,
      this.verifyCode,
      this.phonenumber,
      this.recivePyement,
      this.discount,
      this.reclaimedProducts,
      this.previousDepts,
      this.remainingAmount,
      this.date,
      this.barcode,
      this.location,
      this.delivered,
      this.client,
      this.employee,
      this.products});

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verifyCode = json['verify_code'];
    phonenumber = json['phonenumber'];
    recivePyement = double.parse(json['recive_pyement'].toString());
    discount = double.parse(json['discount'].toString());
    reclaimedProducts = double.parse(json['Reclaimed_products'].toString());
    previousDepts = double.parse(json['previous_depts'].toString());
    remainingAmount = double.parse(json['remaining_amount'].toString());
    date = json['date'];
    barcode = json['barcode'];
    location = json['location'];
    delivered = json['delivered'];
    client = json['client'];
    employee = json['employee'];
    products = json['products'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verify_code'] = this.verifyCode;
    data['phonenumber'] = this.phonenumber;
    data['recive_pyement'] = this.recivePyement;
    data['discount'] = this.discount;
    data['Reclaimed_products'] = this.reclaimedProducts;
    data['previous_depts'] = this.previousDepts;
    data['remaining_amount'] = this.remainingAmount;
    data['date'] = this.date;
    data['barcode'] = this.barcode;
    data['location'] = this.location;
    data['delivered'] = this.delivered;
    data['client'] = this.client;
    data['employee'] = this.employee;
    data['products'] = this.products;
    return data;
  }
}
