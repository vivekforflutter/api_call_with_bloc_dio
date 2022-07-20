
import 'dart:developer';
import 'package:login_api_bloc/api/urls.dart';
import 'package:login_api_bloc/presentation/screens/login/model/login_request_model.dart';
import 'package:login_api_bloc/presentation/screens/registration/model/register_request_model.dart';
import '../presentation/screens/login/model/login_response_model.dart';
import '../presentation/screens/registration/model/register_response_model.dart';
import 'api_helper.dart';

class ApiProvider with ApiHelper{
  Future<LoginResponseModel?> loginApi(LoginRequestModel loginRequest) async{
    var resp = await postTypeHelper(Url.loginUrl, loginRequest);
    if(resp.containsKey("statusCode")){
      if(resp["statusCode"]==200){
       return LoginResponseModel.fromJson(resp["body"]);
      }else if(resp["statusCode"]==49004){
        log("Exception Occurred: ${resp["errorMsg"]}");
        return LoginResponseModel.withError("You are offline. PLease check your internet connection");
      }else{
        throw Exception("Something went wrong");
      }
    }
    return null;
  }
  Future<RegisterResponseModal?> registerApi(RegisterRequestModel requestSignIn) async{

    var resp = await postTypeHelper(Url.registrationUrl, requestSignIn);
    if(resp.containsKey("statusCode")){
      if(resp["statusCode"]==200){
        return RegisterResponseModal.fromJson(resp["body"]);
      }else if(resp["statusCode"]==49004){
        log("Exception Occurred: ${resp["errorMsg"]}");
        return RegisterResponseModal.withError("You are offline. PLease check your internet connection");
      }else{
        throw Exception("Something went wrong");
      }
    }
    return null;
  }
}

