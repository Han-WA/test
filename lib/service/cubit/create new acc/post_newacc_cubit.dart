import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repo.dart';

part 'post_newacc_state.dart';

class PostNewaccCubit extends Cubit<PostNewaccState> {
  final Repo repo;
  PostNewaccCubit(this.repo) : super(PostNewaccInitial());

  void postNewAccData(String email, String password) {
    emit(PostNewaccLoading());
    repo
        .createUserWithEmailAndPassword(email, password)
        .then((_) => emit(PostNewaccSuccess()))
        .catchError((e) {
      print(e.toString());
      emit(PostNewaccFail(e.toString()));
    });
  }
}
