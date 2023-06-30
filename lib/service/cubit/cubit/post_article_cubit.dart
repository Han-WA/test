import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/article_model.dart';
import '../../repo.dart';

part 'post_article_state.dart';

class PostArticleCubit extends Cubit<PostArticleState> {
  final Repo repo;
  PostArticleCubit(this.repo) : super(PostArticleInitial());

  void postArticleData(ArticleModel articleModel) {
    emit(PostArticleLoading());
    repo
        .postArticle(articleModel)
        .then((_) => emit(PostArticleSuccess()))
        .catchError((e) {
      print(e.toString());
      emit(PostArticleFail(e.toString()));
    });
  }
}
