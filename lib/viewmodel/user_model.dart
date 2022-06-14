import 'package:flutter/cupertino.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/repository/user_repository.dart';
import 'package:pigeon_pedigre/services/auth_base.dart';

import '../locator.dart';

enum ViewState { idle, busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  UserRepository userRepository = locator<UserRepository>();
  UserInfoC? _userC;

  UserModel() {
    state = ViewState.busy;
    currentUser();
    state = ViewState.idle;
  }

  @override
  Future<UserInfoC?> createUserWithEmailandPassword(
      String name, String surname, String email, String password) async {
    try {
      state = ViewState.busy;
      UserInfoC? userInfo = await userRepository.createUserWithEmailandPassword(
          name, surname, email, password);
      return userInfo;
    } catch (e) {
      print("userModel hata: " + e.toString());
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserInfoC?>? currentUser() async {
    try {
      state = ViewState.busy;
      _userC = await userRepository.currentUser();
      if (_userC != null) {
        notifyListeners();
        return _userC;
      } else {
        return null;
      }
    } catch (e) {
      print("UserModel currentUser hata: " + e.toString());
      return null;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      bool sonuc = await userRepository.sendPasswordResetEmail(email);
      return sonuc;
    } catch (e) {
      print("user_model hata: " + e.toString());
      rethrow;
    }
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

  UserInfoC? get userC => _userC;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
  }
}
