import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/user_modal_request_idwise.dart';
import '../model/user_modal_response.dart';
import '../repository/detail_user_repository.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  DetailUserBloc(DetailUserRepository detailUserRepository) : super(DetailUserStateInitial()) {
    final DetailUserRepository repository = DetailUserRepository();
    on<DetailUserEvent>((event, emit) async{

      UserModalRequest requestModel =  UserModalRequest(event.id);
      emit(DetailUserStateLoading());
        final myList2 = await repository.DetailUsers(requestModel);
        if(myList2!.email!=null){
          emit(DetailUserStateLoaded(myList2));
        }else
        {
          emit(const DetailUserStateError("Unable to load or data not found"));
        }
    });
  }
}
