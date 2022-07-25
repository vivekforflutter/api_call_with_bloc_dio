import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/user_detail_request_model_pagewise.dart';
import '../model/user_detail_response_model.dart';
import '../repository/user_detail_repository.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc(UserDetailRepository userDetailRepository) : super(UserDetailStateInitial()) {
    final UserDetailRepository repository = UserDetailRepository();
    on<UserDetailEvent>((event, emit) async{

      UserRequestModelPagewise requestModel = UserRequestModelPagewise(event.page);

      try{
        emit(UserDetailStateLoading());
        final myList = await repository.userDetails(requestModel);
        if(myList!.data!=null){
          emit(UserDetailStateLoaded(myList));
        }else
          {
            emit(const UserDetailStateError("Unable to load or data not found"));
          }

      } on NetworkError{
        emit(const UserDetailStateError("No Internet Connection"));
      }
    });
  }
}