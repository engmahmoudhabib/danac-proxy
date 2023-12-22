class CreateIncomeResponseModel {
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

  CreateIncomeResponseModel(
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
      this.barcode});

  CreateIncomeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agent = json['agent'];
    supplier = json['supplier'];
    numTruck = json['num_truck'];
    employee = json['employee'];
    codeVerefy = json['code_verefy'];
    phonenumber = json['phonenumber'];
    recivePyement = double.parse( json['recive_pyement'].toString());
    discount = double.parse(  json['discount'].toString());
    reclaimedProducts = double.parse(  json['Reclaimed_products'].toString());
    previousDepts =  double.parse( json['previous_depts'].toString());
    remainingAmount =  double.parse( json['remaining_amount'].toString());
    date = json['date'];
    barcode = json['barcode'];
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
    return data;
  }
}
