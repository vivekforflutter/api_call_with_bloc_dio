import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/home_page/bloc/user_detail_bloc.dart';
import 'package:login_api_bloc/presentation/widgets/custom_card_widget.dart';
import '../../../../logOut/logOut.dart';
import '../repository/user_detail_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LogOut {
  final UserDetailBloc _userDetailBloc = UserDetailBloc(UserDetailRepository());

  @override
  void initState(){
    super.initState();
    _userDetailBloc.add(const UserDetailEvent("1"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [

          Center(
            child: ElevatedButton(
              child: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {

                logOut(context);
              },
            ),
          ),

        ],
      ),
      body:  BlocProvider<UserDetailBloc>(
        create: (context) => _userDetailBloc,
        child: BlocConsumer<UserDetailBloc, UserDetailState>(
            listener: (context, state1) async {
              if (state1 is UserDetailStateLoading) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Trying to load data")));
              }
              if (state1 is UserDetailStateLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data loaded successfully")));
              }
              if (state1 is UserDetailStateError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state1.message.toString())));
              }
            },
            builder: (context, state) {
              if (state is UserDetailStateLoading) {
                return Center(
                  child: Platform.isAndroid
                      ? const Center(
                        child:  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                      )
                      : const CupertinoActivityIndicator(),
                );
              }
              if (state is UserDetailStateLoaded) {
                return ListView.builder(
                    itemCount: state.responseModel.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      var myData = state.responseModel.data![index];
                      return CustomCardWidget(
                          myData.name.toString(),
                          myData.email.toString(),
                          myData.profilepicture.toString(),
                          myData.location.toString(),
                          myData.createdat.toString(),
                          (index+1).toString(),
                          myData.iD.toString(),
                          );

                    });
              }
              if (state is UserDetailStateError) {
                return const Center(
                  child: Text("In error"),
                );
              }
              return const Center(
                child:  CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
        ),
      )

    );
  }
}
