part of 'post_article_cubit.dart';

abstract class PostArticleState extends Equatable {
  const PostArticleState();

  @override
  List<Object> get props => [];
}

class PostArticleInitial extends PostArticleState {}

class PostArticleLoading extends PostArticleState {}

class PostArticleSuccess extends PostArticleState {}

class PostArticleFail extends PostArticleState {
  final String error;
  const PostArticleFail(this.error);

  @override
  List<Object> get props => [error];
}
