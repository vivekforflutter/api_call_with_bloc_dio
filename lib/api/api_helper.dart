import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_api_bloc/api/urls.dart';

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

  Future getTypeHelper(String endPoint, Map<String, dynamic> query) async {
    var response = await http.get(
      query.isNotEmpty
          ? Uri.http(Url.baseUrl, endPoint, query)
          : Uri.http(Url.baseUrl, endPoint),
    );
    if (kDebugMode) {
      log(response.request.toString());
    }
  }
}
