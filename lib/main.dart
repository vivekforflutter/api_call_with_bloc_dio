import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/home_page/home_page_ui/home_page_screen.dart';
import 'package:login_api_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:login_api_bloc/presentation/screens/login/repository/login_repository.dart';
import 'package:login_api_bloc/presentation/screens/registration/bloc/register_bloc.dart';
import 'package:login_api_bloc/presentation/screens/registration/repository/register_repository.dart';
import 'package:login_api_bloc/presentation/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? logInData;
  logInData = await SharedPreferences.getInstance();
  bool? myUser = false;
  myUser = (logInData.getBool("login") ?? false);
  runApp(MyApp(myUser: myUser,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.myUser}) : super(key: key);
  final bool myUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(LoginRepository())),
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(RegisterRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: myUser==false? const WelcomeScreen():const HomePage(),
      ),
    );
  }
}

