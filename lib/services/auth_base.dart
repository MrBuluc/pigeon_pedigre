import 'package:pigeon_pedigre/models/user_info.dart';

abstract class AuthBase {
  Future<UserInfoC> currentUser();
  Future<bool> signOut();
  Future<UserInfoC> signInWithEmailandPassword(String email, String password);
  Future<UserInfoC> createUserWithEmailandPassword(
      String name, String email, String password);
  Future<bool> sendPasswordResetEmail(String email);
}
