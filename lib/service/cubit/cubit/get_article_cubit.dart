import 'package:bloc/bloc.dart';
import 'package:blogapp/model/article_model.dart';
import 'package:blogapp/service/repo.dart';
import 'package:equatable/equatable.dart';

part 'get_article_state.dart';

class GetArticleCubit extends Cubit<GetArticleState> {
  final Repo repo;
  GetArticleCubit(this.repo) : super(GetArticleInitial()) {
    getArticleData();
  }

  void getArticleData() {
    emit(GetArticleLoading());
    repo
        .getArticle()
        .then((value) => emit(GetArticleSuccess(value)))
        .catchError((e) {
      print(e.toString());
      emit(GetArticleFail(e.toString()));
    });
  }
}
