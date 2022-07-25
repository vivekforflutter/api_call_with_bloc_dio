import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:login_api_bloc/api/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ApiHelper {
  final Dio _dio = Dio();
  Future postTypeHelper(String endPoint, dynamic body) async {
    String url = Url.baseUrl+endPoint;

    try{
      Response response = await _dio.post(url, data: body.toJson());
    return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
  }catch(error){
      return {"statusCode":49004, "body": null, "errorMsg": error.toString()};
    }
  }

  Future getTypeHelper(String endPoint, dynamic query) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    var token = loginData.getString("token");
    log(query.toJson().toString());
    Map<String, dynamic> myQuery = query.toJson();
    String url = Url.baseUrl+endPoint;

    try{
      _dio.options.headers["authorization"] = "Authorization "+token.toString();
      Response response = await _dio.get(url, queryParameters: myQuery);
      log(response.data.toString());
      return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
    }catch(error){
      return {"statusCode":49004, "body": null, "errorMsg": error.toString()};
    }
  }
}
