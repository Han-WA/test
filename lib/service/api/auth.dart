import "package:firebase_auth/firebase_auth.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'cloud_firestore_api.dart';

class Auth {
  CloudFireStoreApi api;
  Auth(this.api);

  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString("password", password);
    // await api.savedUserInfo(userCredential.user);

    return userCredential.user;
  }
}
