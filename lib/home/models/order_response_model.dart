class OrderResponseModel {
  int? clientId;
  String? address;
  String? name;
  String? phonenumber;
  List<Products>? products;
  double? total;
  int? productsNum;
  String? created;
  double? longitude;
  double? latitude;

  OrderResponseModel(
      {this.clientId,
      this.address,
      this.name,
      this.phonenumber,
      this.products,
      this.total,
      this.productsNum,
      this.created,
      this.longitude,
      this.latitude});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    address = json['address'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = double.parse(json['total'].toString());
    productsNum = json['products_num'];
    created = json['created'];
    longitude = double.parse(json['longitude'].toString());
    latitude = double.parse(json['latitude'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['address'] = this.address;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['products_num'] = this.productsNum;
    data['created'] = this.created;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Products {
  int? product;
  int? order;
  int? quantity;
  double? totalPrice;
  String? image;
  String? description;

  Products(
      {this.product,
      this.order,
      this.quantity,
      this.totalPrice,
      this.image,
      this.description});

  Products.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    order = json['order'];
    quantity = json['quantity'];
    totalPrice = double.parse(json['total_price'].toString());
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['order'] = this.order;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
