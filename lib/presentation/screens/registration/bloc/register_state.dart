part of 'register_bloc.dart';


abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterStateInitial extends RegisterState {

  @override
  List<Object> get props => [];
}

class RegisterStateLoading extends RegisterState {}

class RegisterStateLoaded extends RegisterState {
  final RegisterResponseModal responseModel;

  const RegisterStateLoaded(this.responseModel);
}

class RegisterStateError extends RegisterState {
  final String? message;

  const RegisterStateError(this.message);
}