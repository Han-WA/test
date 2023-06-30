part of 'get_article_cubit.dart';

abstract class GetArticleState extends Equatable {
  const GetArticleState();

  @override
  List<Object> get props => [];
}

class GetArticleInitial extends GetArticleState {}

class GetArticleLoading extends GetArticleState {}

class GetArticleSuccess extends GetArticleState {
  final List<ArticleModel> article;
  const GetArticleSuccess(this.article);

  @override
  List<Object> get props => [article];
}

class GetArticleFail extends GetArticleState {
  final String error;
  const GetArticleFail(this.error);

  @override
  List<Object> get props => [error];
}
