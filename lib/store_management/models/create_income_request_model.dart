class CreateIncomeRequestModel {
  String? supplier;
  String? agent;
  String? codeVerefy;
  String? phonenumber;
  String? recivePyement;
  String? discount;
  String? reclaimedProducts;
  String? previousDepts;
  String? remainingAmount;
  String? numTruck;

  CreateIncomeRequestModel(
      {this.supplier,
      this.agent,
      this.codeVerefy,
      this.phonenumber,
      this.recivePyement,
      this.discount,
      this.reclaimedProducts,
      this.previousDepts,
      this.remainingAmount,
      this.numTruck});

  CreateIncomeRequestModel.fromJson(Map<String, dynamic> json) {
    supplier = json['supplier'];
    agent = json['agent'];
    codeVerefy = json['code_verefy'];
    phonenumber = json['phonenumber'];
    recivePyement = json['recive_pyement'];
    discount = json['discount'];
    reclaimedProducts = json['Reclaimed_products'];
    previousDepts = json['previous_depts'];
    remainingAmount = json['remaining_amount'];
    numTruck = json['num_truck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier'] = this.supplier;
    data['agent'] = this.agent;
    data['code_verefy'] = this.codeVerefy;
    data['phonenumber'] = this.phonenumber;
    data['recive_pyement'] = this.recivePyement;
    data['discount'] = this.discount;
    data['Reclaimed_products'] = this.reclaimedProducts;
    data['previous_depts'] = this.previousDepts;
    data['remaining_amount'] = this.remainingAmount;
    data['num_truck'] = this.numTruck;
    return data;
  }
}
