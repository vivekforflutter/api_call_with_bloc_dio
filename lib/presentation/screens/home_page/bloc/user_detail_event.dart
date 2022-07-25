part of 'user_detail_bloc.dart';

class UserDetailEvent extends Equatable {
  final String page;

  const UserDetailEvent(this.page);

  @override
  List<Object> get props => [page];
}

