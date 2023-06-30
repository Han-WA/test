import 'package:blogapp/model/article_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'api.dart';
import 'api/auth.dart';

class Repo {
  Api api;
  Auth auth;

  Repo(this.api, this.auth);

  Future<List<ArticleModel>> getArticle() => api.getArticle();

  Future<void> postArticle(ArticleModel articleModel) =>
      api.postArticle(articleModel: articleModel);

  Future<void> createUserWithEmailAndPassword(String email, String password) =>
      auth.createUserWithEmailAndPassword(email, password);
}
