class MediumTwoResponseModel {
  int? id;
  int? quantity;
  String? product;
  int? mediumtwo;
  String? image;
  double? salePrice;
  String? description;

  MediumTwoResponseModel({
    this.id,
    this.quantity,
    this.product,
    this.mediumtwo,
    this.image,
    this.salePrice,
    this.description,
  });

  MediumTwoResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'];
    mediumtwo = json['mediumtwo'];
    image = json['image'];
    salePrice = double.parse(json['sale_price'].toString());
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['product'] = this.product;
    data['mediumtwo'] = this.mediumtwo;
    data['image'] = this.image;
    data['sale_price'] = this.salePrice;
    data['description'] = this.description;
    return data;
  }
}
