class LoginResponseModel {
  String? id;
  int? code;
  String? message;
  Data? data;

  LoginResponseModel({this.id, this.code, this.message, this.data});

  LoginResponseModel.withError(String errorMsg){
    message = errorMsg;
  }

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$id'] = id;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  int? iD;
  String? name;
  String? email;
  String? token;

  Data({this.id, this.iD, this.name, this.email, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    iD = json['Id'];
    name = json['Name'];
    email = json['Email'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$id'] = id;
    data['Id'] = id;
    data['Name'] = name;
    data['Email'] = email;
    data['Token'] = token;
    return data;
  }
}
