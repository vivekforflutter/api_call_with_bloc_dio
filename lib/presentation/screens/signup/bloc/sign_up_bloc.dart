import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/signup_request_model.dart';
import '../model/signup_response_model.dart';
import '../repository/signup_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(SignUpRepository signUpRepository) : super(SignUpStateInitial()) {
    final SignUpRepository repository = SignUpRepository();
    on<SignUpEvent>((event, emit) async{

      SignupRequestModel requestModel = SignupRequestModel(event.email,event.name,event.password);

      try{
        emit(SignUpStateLoading());
        final myList = await repository.signupUser(requestModel);
        if(myList!.code==0){
          emit(SignUpStateLoaded(myList));
        }else if(myList.code == 1){
          if(myList.message != null){
            emit(SignUpStateError(myList.message));
          }
        }else if(myList.code == null){
          if(myList.message != null){
            emit(SignUpStateError(myList.message));
          }
        }
      } on NetworkError{
        emit(const SignUpStateError("No Internet Connection"));
      }
    });
  }
}
