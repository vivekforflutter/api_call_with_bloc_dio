part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpStateInitial extends SignUpState {

  @override
  List<Object> get props => [];
}

class SignUpStateLoading extends SignUpState {}

class SignUpStateLoaded extends SignUpState {
  final SignUpResponseModel responseModel;

  const SignUpStateLoaded(this.responseModel);
}

class SignUpStateError extends SignUpState {
  final String? message;

  const SignUpStateError(this.message);
}
