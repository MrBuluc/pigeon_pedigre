import 'package:flutter/cupertino.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/repository/user_repository.dart';
import 'package:pigeon_pedigre/services/auth_base.dart';

import '../locator.dart';

enum ViewState { idle, busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  UserRepository userRepository = locator<UserRepository>();
  //UserInfoC _userC;

  @override
  Future<UserInfoC> createUserWithEmailandPassword(
      String name, String email, String password) {
    // TODO: implement createUserWithEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<UserInfoC> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<UserInfoC> signInWithEmailandPassword(String email, String password) {
    // TODO: implement signInWithEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
