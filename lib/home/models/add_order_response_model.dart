class AddOrderResponseModel {
  int? id;
  Client? client;
  List<Products>? products;
  double? total;
  int? productsNum;
  String? created;
  String? deliveryDate;
  bool? delivered;

  AddOrderResponseModel(
      {this.id,
      this.client,
      this.products,
      this.total,
      this.productsNum,
      this.created,
      this.deliveryDate,
      this.delivered});

  AddOrderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total =double.parse( json['total'].toString());
    productsNum = json['products_num'];
    created = json['created'];
    deliveryDate = json['delivery_date'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['products_num'] = this.productsNum;
    data['created'] = this.created;
    data['delivery_date'] = this.deliveryDate;
    data['delivered'] = this.delivered;
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? address;
  String? phonenumber;
  String? category;
  String? notes;
  String? location;
  double? totalPoints;

  Client(
      {this.id,
      this.name,
      this.address,
      this.phonenumber,
      this.category,
      this.notes,
      this.location,
      this.totalPoints});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phonenumber = json['phonenumber'];
    category = json['category'];
    notes = json['notes'];
    location = json['location'];
    totalPoints =double.parse( json['total_points'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phonenumber'] = this.phonenumber;
    data['category'] = this.category;
    data['notes'] = this.notes;
    data['location'] = this.location;
    data['total_points'] = this.totalPoints;
    return data;
  }
}

class Products {
  int? product;
  int? order;
  int? quantity;
  int? totalPrice;

  Products({this.product, this.order, this.quantity, this.totalPrice});

  Products.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    order = json['order'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['order'] = this.order;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    return data;
  }
}
