import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseService {
  //login
  Future<UserCredential> loginUserWithFirebase(String email, String password);
  //register
  Future<UserCredential> signUpWithFirebase(String email, String password);
//sign out
  void signOutUser();
  //
  bool isUserLoggedin();
}
