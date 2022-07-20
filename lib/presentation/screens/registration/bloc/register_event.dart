part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterEvent(this.name, this.email, this.password);

  @override
  List<Object> get props => [name, email, password];
}
