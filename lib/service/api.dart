import 'package:blogapp/model/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  Future<List<ArticleModel>> getArticle() async {
    try {
      final response =
          await FirebaseFirestore.instance.collection("all_blogs").get();

      if (response.docs.isEmpty) {
        throw "Missing Data!";
      } else {
        List<ArticleModel> articleData =
            response.docs.map((e) => ArticleModel.fromJson(e.data())).toList();
        return articleData;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> postArticle({required ArticleModel articleModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("all_blogs")
          .doc(articleModel.title)
          .set(articleModel.toJson());
    } catch (e) {
      throw (e.toString());
    }
  }
}
