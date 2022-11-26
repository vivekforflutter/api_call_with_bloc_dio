import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_api_bloc/helper/text_field_validator.dart';
import 'package:login_api_bloc/presentation/screens/home_page/home_page_ui/home_page_screen.dart';
import 'package:login_api_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/login/login_in_ui.dart';
import 'package:login_api_bloc/presentation/screens/registration/bloc/register_bloc.dart';
import 'package:login_api_bloc/presentation/screens/registration/repository/register_repository.dart';
import '../../widgets/custom_text_field.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Validator{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
    final RegisterBloc _registerBloc = RegisterBloc(RegisterRepository());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: BlocProvider<RegisterBloc>(
            create: (context) => _registerBloc,
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, userRegisterState) {
                if (userRegisterState is RegisterStateLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(userRegisterState.responseModel.message.toString())));
                }
                if (userRegisterState is RegisterStateError) {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(userRegisterState.message.toString())));
                }
              },
              child: BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterStateLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.blue,
                          content: Text("Logged in successfully")));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
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
                    child: const Text('Sign Up',style: TextStyle(fontSize: 17,color: Colors.black),),
                    onPressed: () {

                      if(formkey.currentState!.validate()){
                        BlocProvider.of<RegisterBloc>(context).add(RegisterEvent(
                            nameController.text.toString(),
                            emailController.text.toString(),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                        image: AssetImage("assets/image2.png"), fit: BoxFit.cover),
                  ),
                ),
                const Center(
                  child: Text(
                    '  Create account',
                    style: TextStyle(
                      height: 3,
                      leadingDistribution: TextLeadingDistribution.proportional,
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,),
                  ),
                ),


                Container(
                    margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: CustomTextField(
                        autoValidate: AutovalidateMode.disabled,
                        controller: nameController,
                        obscureText: false,
                        hintText: "Name",
                        onChanged: (v){
                        },
                        validator: (v){
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
                        'Login',
                        style: TextStyle(fontSize: 15,color: Colors.white),
                      ),
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignIn()));
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
