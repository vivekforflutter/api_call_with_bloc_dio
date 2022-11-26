import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:login_api_bloc/api/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ApiHelper {
  final Dio _dio = Dio();
  Future postTypeHelper(String endPoint, dynamic body) async {
    String url = Url.baseUrl+endPoint;

    try{
      Response response = await _dio.post(url, data: body.toJson());
      if(kDebugMode){
        log(response.data.toString());
      }
    return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
  }on DioError catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        return {"statusCode": 49004, "body": null, "errorMsg": "Time-Out"};
      } else if (DioErrorType.response == e.type) {
        if (kDebugMode) {
          log(e.response!.data.toString());
        }
        if(e.response!.statusCode == 422) {
          return {
            "statusCode": 49004,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else if(e.response!.statusCode == 403) {
          return {
            "statusCode": 403,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else if(e.response!.statusCode == 404) {
          return {
            "statusCode": 404,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else{
          return {
            "statusCode": 49004,
            "body": null,
            "errorMsg": "Something went wrong"
          };
        }
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          return {
            "statusCode": 49004,
            "body": null,
            "errorMsg": "Failed to connect"
          };
        }
      } else {
        return {
          "statusCode": 49004,
          "body": null,
          "errorMsg": "Problem connecting to the server. Please try again."
        };
      }
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
      if(kDebugMode){
        log(response.data.toString());
      }
      return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
    }on DioError catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        return {"statusCode": 49004, "body": null, "errorMsg": "Time-Out"};
      } else if (DioErrorType.response == e.type) {
        if (kDebugMode) {
          log(e.response!.data.toString());
        }
        if(e.response!.statusCode == 422) {
          return {
            "statusCode": 49004,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else if(e.response!.statusCode == 403) {
          return {
            "statusCode": 403,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else if(e.response!.statusCode == 404) {
          return {
            "statusCode": 404,
            "body": e.response!.data,
            "errorMsg": e.response!.statusMessage.toString()
          };
        }
        else{
          return {
            "statusCode": 49004,
            "body": null,
            "errorMsg": "Something went wrong"
          };
        }
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          return {
            "statusCode": 49004,
            "body": null,
            "errorMsg": "Failed to connect"
          };
        }
      } else {
        return {
          "statusCode": 49004,
          "body": null,
          "errorMsg": "Problem connecting to the server. Please try again."
        };
      }
    }
  }
}
