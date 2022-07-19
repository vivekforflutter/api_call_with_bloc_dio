part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String name;
  final String password;

  const SignUpEvent(this.email, this.name,this.password);

  @override
  List<Object> get props => [email, password];
}