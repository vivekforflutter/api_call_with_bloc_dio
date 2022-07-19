import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:login_api_bloc/presentation/screens/login/repository/login_repository.dart';
import 'package:login_api_bloc/presentation/screens/signup/bloc/sign_up_bloc.dart';
import 'package:login_api_bloc/presentation/screens/signup/repository/signup_repository.dart';
import 'package:login_api_bloc/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(LoginRepository())),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(SignUpRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}

