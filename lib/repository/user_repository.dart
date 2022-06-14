import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/services/auth_base.dart';
import 'package:pigeon_pedigre/services/firebase/firebase_auth_service.dart';
import 'package:pigeon_pedigre/services/firebase/firestore_service.dart';

import '../locator.dart';

class UserRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  @override
  Future<UserInfoC?> createUserWithEmailandPassword(
      String name, String surname, String email, String password) async {
    UserInfoC userInfoC = await _firebaseAuthService
        .createUserWithEmailandPassword(name, surname, email, password);

    bool sonuc = await _firestoreService.setUser(userInfoC);

    if (sonuc) {
      return await _firestoreService.readUser(userInfoC.id!);
    } else {
      return null;
    }
  }

  @override
  Future<UserInfoC?>? currentUser() async {
    UserInfoC? userInfoC = await _firebaseAuthService.currentUser();
    if (userInfoC != null) {
      return await _firestoreService.readUser(userInfoC.id!);
    } else {
      return null;
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<UserInfoC> signInWithEmailandPassword(String email, String password) {
    //sifre = Hkcblc22@
    // TODO: implement signInWithEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
