part of 'detail_user_bloc.dart';

abstract class DetailUserState extends Equatable {
  const DetailUserState();

  @override
  List<Object?> get props => [];
}

class DetailUserStateInitial extends DetailUserState {

  @override
  List<Object> get props => [];
}

class DetailUserStateLoading extends DetailUserState {}

class DetailUserStateLoaded extends DetailUserState {
  final UserModalResponse responseModel;

  const DetailUserStateLoaded(this.responseModel);
}

class DetailUserStateError extends DetailUserState {
  final String? message;

  const DetailUserStateError(this.message);
}
