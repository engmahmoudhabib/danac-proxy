class CreateCartResponseModel {
  int? id;
  int? customer;
  int? getItemsNum;
  int? totalCartPrice;

  CreateCartResponseModel(
      {this.id, this.customer, this.getItemsNum, this.totalCartPrice});

  CreateCartResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    getItemsNum = json['get_items_num'];
    totalCartPrice = json['total_cart_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer'] = this.customer;
    data['get_items_num'] = this.getItemsNum;
    data['total_cart_price'] = this.totalCartPrice;
    return data;
  }
}
