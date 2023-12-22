class MediumTableResponseModel {
  int? id;
  String? product;
  double? discount;
  int? numItem;
  double? totalPrice;
  int? medium;
  int? numPerItem;
  int? salePrice;

  MediumTableResponseModel({
    this.id,
    this.product,
    this.discount,
    this.numItem,
    this.totalPrice,
    this.medium,
    this.numPerItem,
    this.salePrice,
  });

  MediumTableResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    discount = double.parse(json['discount'].toString());
    numItem = json['num_item'];
    totalPrice = double.parse(json['total_price'].toString());
    medium = json['medium'];
    numPerItem = json['num_per_item'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product'] = this.product;
    data['discount'] = this.discount;
    data['num_item'] = this.numItem;
    data['total_price'] = this.totalPrice;
    data['medium'] = this.medium;
    data['num_per_item'] = this.numPerItem;
    data['sale_price'] = this.salePrice;
    return data;
  }
}
