part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailStateInitial extends UserDetailState {

  @override
  List<Object> get props => [];
}

class UserDetailStateLoading extends UserDetailState {}

class UserDetailStateLoaded extends UserDetailState {
  final UserDetailsResponseModel responseModel;

  const UserDetailStateLoaded(this.responseModel);
}

class UserDetailStateError extends UserDetailState {
  final String? message;

  const UserDetailStateError(this.message);
}
