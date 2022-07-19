import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/signup/repository/signup_repository.dart';

import '../../../constant/text_field_validator.dart';
import '../../widgets/text_field.dart';
import 'bloc/sign_up_bloc.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Validator {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final SignUpBloc _signUpBloc = SignUpBloc(SignUpRepository());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BlocProvider<SignUpBloc>(
              create: (context) => _signUpBloc,
              child: BlocListener<SignUpBloc, SignUpState>(
                listener: (context, userSignUpState) {
                  if (userSignUpState is SignUpStateLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text(userSignUpState.responseModel.message.toString())));
                  }
                  if (userSignUpState is SignUpStateError) {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(userSignUpState.message.toString())));
                  }
                },
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpStateLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text("Sign up is successful")));
                    }
                  },
                  builder: (context, state) {
                    if (state is SignUpStateLoading) {
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
                      child: const Text('Sign Up',style: TextStyle(fontSize: 17,color: Colors.black),),
                      onPressed: () {

                        if(formkey.currentState!.validate()){
                          BlocProvider.of<SignUpBloc>(context).add(SignUpEvent(
                              emailController.text.toString(),
                              nameController.text.toString(),
                              passwordController.text.toString()));

                        }
                      },
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
                const Center(
                    child: Text("Create account",
                      style: TextStyle(
                        height: 3,
                      color: Colors.white,
                      leadingDistribution: TextLeadingDistribution.proportional,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),)),
                const SizedBox(height: 50,),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: CustomTextField(
                        autoValidate: AutovalidateMode.disabled,
                        controller: nameController,
                        obscureText: false,
                        hintText: "Name",
                        onChanged: (v){
                        },
                        validator: (v) {
                          return null;
                        }
                    )
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: CustomTextField(
                        autoValidate: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        obscureText: false,
                        hintText: "Email",
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
                      obscureText: true,
                      hintText: "Password",
                      onChanged: (v){},
                      validator: (v){
                        return null;
                      },
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
