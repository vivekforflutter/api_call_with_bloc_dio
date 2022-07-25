part of 'detail_user_bloc.dart';

class DetailUserEvent extends Equatable {
  final String id;

  const DetailUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
