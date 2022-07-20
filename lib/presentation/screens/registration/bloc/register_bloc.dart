
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../repository/register_repository.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterRepository registerRepository) : super(RegisterStateInitial()) {
    final RegisterRepository repository = RegisterRepository();
    on<RegisterEvent>((event, emit) async{

     RegisterRequestModel requestModel = RegisterRequestModel(event.name, event.email, event.password);

     try{
       emit(RegisterStateLoading());
       final myList = await repository.registerUser(requestModel);
       if(myList!.code==0){
         emit(RegisterStateLoaded(myList));
       }else if(myList.code == 1){
         if(myList.message != null){
           emit(RegisterStateError(myList.message));
         }
       }else if(myList.code == null){
         if(myList.message != null){
           emit(RegisterStateError(myList.message));
         }
       }
     } on NetworkError{
       emit(const RegisterStateError("No Internet Connection"));
     }
    });
  }
}
