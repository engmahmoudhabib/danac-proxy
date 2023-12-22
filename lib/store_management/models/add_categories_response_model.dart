class AddCategoriesResponseModel {
  String? message;

  AddCategoriesResponseModel({this.message});

  AddCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class AddCategoriesRequestModel {
  String? name;

  AddCategoriesRequestModel({this.name});

  AddCategoriesRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
