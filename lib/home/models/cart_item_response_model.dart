class GetCartItemsResponseModel {
  int? id;
  int? quantity;
  int? cart;
  Products? products;
  int? totalPriceOfItem;

  GetCartItemsResponseModel(
      {this.id,
      this.quantity,
      this.cart,
      this.products,
      this.totalPriceOfItem});

  GetCartItemsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    cart = json['cart'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
    totalPriceOfItem = json['total_price_of_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['cart'] = this.cart;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    data['total_price_of_item'] = this.totalPriceOfItem;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? image;
  String? description;
  int? salePrice;

  Products({this.id, this.name, this.image, this.description, this.salePrice});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['sale_price'] = this.salePrice;
    return data;
  }
}
