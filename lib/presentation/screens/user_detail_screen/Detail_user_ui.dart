import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/presentation/screens/user_detail_screen/repository/detail_user_repository.dart';
import 'bloc/detail_user_bloc.dart';

class DetailUserScreen extends StatefulWidget {
  final String id;
  const DetailUserScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  final DetailUserBloc _DetailUserBloc = DetailUserBloc(DetailUserRepository());
  @override
  void initState() {
    super.initState();
    _DetailUserBloc.add(DetailUserEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User details"),
      ),
      body: SingleChildScrollView(
          child: BlocProvider<DetailUserBloc>(
        create: (context) => _DetailUserBloc,
        child: BlocConsumer<DetailUserBloc, DetailUserState>(
            listener: (context, state2) async {
          if (state2 is DetailUserStateLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Trying to load data")));
          }
          if (state2 is DetailUserStateLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Data loaded successfully")));
          }
          if (state2 is DetailUserStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state2.message.toString())));
          }
        }, builder: (context, state) {
          if (state is DetailUserStateLoading) {
            return Center(
              child: Platform.isAndroid
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : const CupertinoActivityIndicator(),
            );
          }
          if (state is DetailUserStateLoaded) {
            var userDetails = state.responseModel;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID : " + userDetails.iD.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown)),
                  const SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:
                          Image.network(userDetails.profilepicture.toString())),
                  Text(
                    userDetails.name.toString(),
                    style: const TextStyle(
                        fontSize: 30, letterSpacing: 2, wordSpacing: 3),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        userDetails.email.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        userDetails.createdat.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        userDetails.location.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (state is DetailUserStateError) {
            return const Center(
              child: Text("In error"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }),
      )),
    );
  }
}
