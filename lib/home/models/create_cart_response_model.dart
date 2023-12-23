class CreateCartResponseModel {
  int? id;
  int? quantity;
  int? products;
  int? cart;

  CreateCartResponseModel({this.id, this.quantity, this.products, this.cart});

  CreateCartResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    products = json['products'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['products'] = this.products;
    data['cart'] = this.cart;
    return data;
  }
}
