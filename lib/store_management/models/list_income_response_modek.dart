class ListIncomeResponseModel {
  int? id;
  String? agent;
  int? supplier;
  int? numTruck;
  int? employee;
  int? codeVerefy;
  String? phonenumber;
  double? recivePyement;
  double? discount;
  double? reclaimedProducts;
  double? previousDepts;
  double? remainingAmount;
  String? date;
  String? barcode;
  List<Products>? products;

  ListIncomeResponseModel(
      {this.id,
      this.agent,
      this.supplier,
      this.numTruck,
      this.employee,
      this.codeVerefy,
      this.phonenumber,
      this.recivePyement,
      this.discount,
      this.reclaimedProducts,
      this.previousDepts,
      this.remainingAmount,
      this.date,
      this.barcode,
      this.products});

  ListIncomeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agent = json['agent'];
    supplier = json['supplier'];
    numTruck = json['num_truck'];
    employee = json['employee'];
    codeVerefy = json['code_verefy'];
    phonenumber = json['phonenumber'];
    recivePyement = double.parse(json['recive_pyement'].toString());
    discount = double.parse(json['discount'].toString());
    reclaimedProducts = double.parse(json['Reclaimed_products'].toString());
    previousDepts = double.parse(json['previous_depts'].toString());
    remainingAmount = double.parse(json['remaining_amount'].toString());
    date = json['date'];
    barcode = json['barcode'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent'] = this.agent;
    data['supplier'] = this.supplier;
    data['num_truck'] = this.numTruck;
    data['employee'] = this.employee;
    data['code_verefy'] = this.codeVerefy;
    data['phonenumber'] = this.phonenumber;
    data['recive_pyement'] = this.recivePyement;
    data['discount'] = this.discount;
    data['Reclaimed_products'] = this.reclaimedProducts;
    data['previous_depts'] = this.previousDepts;
    data['remaining_amount'] = this.remainingAmount;
    data['date'] = this.date;
    data['barcode'] = this.barcode;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? numPerItem;
  double? salePrice;
  int? numItem;
  double? totalPrice;
  int? incoming;

  Products(
      {this.id,
      this.name,
      this.numPerItem,
      this.salePrice,
      this.numItem,
      this.totalPrice,
      this.incoming});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numPerItem = json['num_per_item'];
    salePrice = double.parse(json['sale_price'].toString());
    numItem = json['num_item'];
    totalPrice =double.parse( json['total_price'].toString());
    incoming = json['incoming'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['num_per_item'] = this.numPerItem;
    data['sale_price'] = this.salePrice;
    data['num_item'] = this.numItem;
    data['total_price'] = this.totalPrice;
    data['incoming'] = this.incoming;
    return data;
  }
}
