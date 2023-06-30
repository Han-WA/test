import 'package:blogapp/service/api/auth.dart';
import 'package:blogapp/service/api/cloud_firestore_api.dart';
import 'package:blogapp/service/cubit/create%20new%20acc/post_newacc_cubit.dart';
import 'package:blogapp/service/cubit/cubit/get_article_cubit.dart';
import 'package:blogapp/service/cubit/cubit/post_article_cubit.dart';
import 'package:get_it/get_it.dart';
import '../api.dart';
import '../repo.dart';

var getIt = GetIt.I;

void locator() {
  final api = Api();
  getIt.registerLazySingleton(() => api);

  final cloudFireStoreApi = CloudFireStoreApi();
  getIt.registerLazySingleton(() => cloudFireStoreApi);

  final auth = Auth(getIt.call());
  getIt.registerLazySingleton(() => auth);

  final repo = Repo(getIt.call(), getIt.call());
  getIt.registerLazySingleton(() => repo);

  final getArticleCubit = GetArticleCubit(getIt.call());
  getIt.registerLazySingleton(() => getArticleCubit);

  final postArticleCubit = PostArticleCubit(getIt.call());
  getIt.registerLazySingleton(() => postArticleCubit);

  final postNewAccCubit = PostNewaccCubit(getIt.call());
  getIt.registerLazySingleton(() => postNewAccCubit);
}
