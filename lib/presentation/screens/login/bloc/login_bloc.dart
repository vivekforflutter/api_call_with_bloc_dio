
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_api_bloc/presentation/screens/login/model/login_request_model.dart';
import 'package:login_api_bloc/presentation/screens/login/model/login_response_model.dart';
import 'package:login_api_bloc/presentation/screens/login/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginRepository loginRepository) : super(LoginStateInitial()) {
    final LoginRepository repository = LoginRepository();
    on<LoginEvent>((event, emit) async{

     LoginRequestModel requestModel = LoginRequestModel(event.email, event.password);

     try{
       emit(LoginStateLoading());
       final myList = await repository.loginUser(requestModel);
       if(myList!.code==0){
         emit(LoginStateLoaded(myList));
       }else if(myList.code == 1){
         if(myList.message != null){
           emit(LoginStateError(myList.message));
         }
       }else if(myList.code == null){
         if(myList.message != null){
           emit(LoginStateError(myList.message));
         }
       }
     } on NetworkError{
       emit(const LoginStateError("No Internet Connection"));
     }
    });
  }
}
