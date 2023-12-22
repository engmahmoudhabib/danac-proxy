class AddToMediumResponseModel {
  int? id;
  double? discount;
  int? numItem;
  double? totalPrice;
  int? medium;
  String? product;

  AddToMediumResponseModel({
    this.id,
    this.discount,
    this.numItem,
    this.totalPrice,
    this.medium,
    this.product,
  });

  AddToMediumResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discount = double.parse( json['discount'].toString());
    numItem = json['num_item'];
    totalPrice = double.parse(json['total_price'].toString());
    medium = json['medium'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount'] = this.discount;
    data['num_item'] = this.numItem;
    data['total_price'] = this.totalPrice;
    data['medium'] = this.medium;
    data['product'] = this.product;
    return data;
  }
}
