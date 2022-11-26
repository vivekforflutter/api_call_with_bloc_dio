import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_api_bloc/helper/text_field_validator.dart';
import 'package:login_api_bloc/presentation/screens/home_page/home_page_ui/home_page_screen.dart';
import 'package:login_api_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/login/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_text_field.dart';
import '../registration/registration_ui.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with Validator{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences loginData;
  late bool newUser;

  final formkey = GlobalKey<FormState>();
    final LoginBloc _loginBloc = LoginBloc(LoginRepository());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: BlocProvider<LoginBloc>(
            create: (context) => _loginBloc,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, userLoginState) {
                if (userLoginState is LoginStateLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(userLoginState.responseModel.message.toString())));
                }
                if (userLoginState is LoginStateError) {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(userLoginState.message.toString())));
                }
              },
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) async {
                  if (state is LoginStateLoaded) {
                     if (kDebugMode) {
                       log(state.responseModel.data!.token.toString());
                     }
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.blue,
                          content: Text("Logged in successfully")));
                      loginData = await SharedPreferences.getInstance();
                      loginData.setString("token", state.responseModel.data!.token.toString());
                      loginData.setBool('login', true);
                      loginData.setString('username', state.responseModel.data!.email.toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomePage()));
                     }
                },
                builder: (context, state) {
                  if (state is LoginStateLoading) {
                    return SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Platform.isAndroid
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const CupertinoActivityIndicator(),
                      ),
                    );
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 55),
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),
                    ),
                    child: const Text('Log In',style: TextStyle(fontSize: 17,color: Colors.black),),
                    onPressed: () {


                      if(formkey.currentState!.validate()){
                        BlocProvider.of<LoginBloc>(context).add(LoginEvent(
                            emailController.text.toString(),
                            passwordController.text.toString()));
                        }
                      }
                  );
                },
              ),
            ),
          )
        ),
                  backgroundColor: Colors.black,

        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '  Let\'s sign you in.',
                  style: TextStyle(
                    height: 3,
                    leadingDistribution: TextLeadingDistribution.proportional,
                      letterSpacing: 0.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,),
                ),
                const Text(
                  '  Welcome back\n  You\'ve been missed',
                  style: TextStyle(
                    height: 1.3,
                    leadingDistribution: TextLeadingDistribution.even,
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 30,),
                ),
                const SizedBox(height: 50,),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: CustomTextField(
                    autoValidate: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    obscureText: false,
                    hintText: "Username",
                    onChanged: (v){
                    },
                    validator: (str) {
                     return validateEmail(str!);
                    }
                )
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: CustomTextField(
                      autoValidate: AutovalidateMode.disabled,
                      controller: passwordController,
                      obscureText: false,
                      hintText: "Password",
                      onChanged: (v){},
                      validator: (v){
                        return null;
                      },
                    )
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Does not have account?',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 15,color: Colors.white),
                      ),
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      },
                    )
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
