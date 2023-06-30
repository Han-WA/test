part of 'post_newacc_cubit.dart';

abstract class PostNewaccState extends Equatable {
  const PostNewaccState();

  @override
  List<Object> get props => [];
}

class PostNewaccInitial extends PostNewaccState {}

class PostNewaccLoading extends PostNewaccState {}

class PostNewaccSuccess extends PostNewaccState {}

class PostNewaccFail extends PostNewaccState {
  final String error;
  const PostNewaccFail(this.error);

  @override
  List<Object> get props => [error];
}

