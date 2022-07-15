part of 'login_bloc.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {

  @override
  List<Object> get props => [];
}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {
  final LoginResponseModel responseModel;

  const LoginStateLoaded(this.responseModel);
}

class LoginStateError extends LoginState {
  final String? message;

  const LoginStateError(this.message);
}