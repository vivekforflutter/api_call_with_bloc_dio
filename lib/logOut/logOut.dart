import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/screens/login/sign_in_screen.dart';

mixin LogOut{
  void logOut(BuildContext context) async{
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.remove("login");
    loginData.remove("token");
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SignIn()));
  }
}