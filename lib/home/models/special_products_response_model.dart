class SpecialProductsResponseModel {
  int? id;
  String? name;
  String? image;
  String? description;
  int? quantity;
  double? purchasingPrice;
  String? notes;
  int? limitLess;
  int? limitMore;
  int? numPerItem;
  int? itemPerCarton;
  int? salePrice;
  String? added;
  String? barcode;
  int? category;

  SpecialProductsResponseModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.quantity,
      this.purchasingPrice,
      this.notes,
      this.limitLess,
      this.limitMore,
      this.numPerItem,
      this.itemPerCarton,
      this.salePrice,
      this.added,
      this.barcode,
      this.category});

  SpecialProductsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    quantity = json['quantity'];
    purchasingPrice = double.parse(json['purchasing_price'].toString());
    notes = json['notes'];
    limitLess = json['limit_less'];
    limitMore = json['limit_more'];
    numPerItem = json['num_per_item'];
    itemPerCarton = json['item_per_carton'];
    salePrice = json['sale_price'];
    added = json['added'];
    barcode = json['barcode'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['purchasing_price'] = this.purchasingPrice;
    data['notes'] = this.notes;
    data['limit_less'] = this.limitLess;
    data['limit_more'] = this.limitMore;
    data['num_per_item'] = this.numPerItem;
    data['item_per_carton'] = this.itemPerCarton;
    data['sale_price'] = this.salePrice;
    data['added'] = this.added;
    data['barcode'] = this.barcode;
    data['category'] = this.category;
    return data;
  }
}
