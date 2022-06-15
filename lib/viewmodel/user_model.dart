import 'package:flutter/cupertino.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
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
      printError("createUserWithEmailandPassword", e);
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
      printError("currentUser", e);
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
      printError("sendPasswordResetEmail", e);
      rethrow;
    }
  }

  @override
  Future<UserInfoC?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserInfoC? userInfoC =
          await userRepository.signInWithEmailandPassword(email, password);
      if (userInfoC != null) {
        _userC = userInfoC;
        return _userC;
      } else {
        return null;
      }
    } catch (e) {
      printError("signInWithEmailandPassword", e);
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.busy;
      bool sonuc = await userRepository.signOut();
      if (sonuc) {
        _userC = null;
      }
      return sonuc;
    } catch (e) {
      printError("signOut", e);
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  Future<List<Pigeon>> getPigeons() async {
    try {
      return await userRepository.getPigeons();
    } catch (e) {
      printError("getPigeons", e);
      return [];
    }
  }

  Future<bool> addPigeon(Pigeon pigeon) async {
    try {
      return await userRepository.addPigeon(pigeon);
    } catch (e) {
      printError("addPigeon", e);
      rethrow;
    }
  }

  void printError(String methodName, Object e) {
    print("Usermodel $methodName hata: " + e.toString());
  }

  UserInfoC? get userC => _userC;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
  }
}
