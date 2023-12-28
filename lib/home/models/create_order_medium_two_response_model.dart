class CreateOrderMediumTwoResponseModel {
  int? id;
  String? client;
  String? phonenumber;
  int? productsNum;
  double? totalPrice;
  String? created;
  String? address;
  String? deliveryDate;
  bool? delivered;
  List<int>? products;

  CreateOrderMediumTwoResponseModel({
    this.id,
    this.client,
    this.phonenumber,
    this.productsNum,
    this.totalPrice,
    this.created,
    this.deliveryDate,
    this.delivered,
    this.products,
    this.address,
  });

  CreateOrderMediumTwoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    phonenumber = json['phonenumber'];
    productsNum = json['products_num'];
    totalPrice = double.parse(json['total_price'].toString());
    created = json['created'];
    address = json['address'];
    deliveryDate = json['delivery_date'];
    delivered = json['delivered'];
    products = json['products'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client'] = this.client;
    data['phonenumber'] = this.phonenumber;
    data['products_num'] = this.productsNum;
    data['total_price'] = this.totalPrice;
    data['created'] = this.created;
    data['delivery_date'] = this.deliveryDate;
    data['delivered'] = this.delivered;
    data['products'] = this.products;
    data['address'] = this.address;
    return data;
  }
}
