import 'package:pigeon_pedigre/models/pigeon.dart';
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
  Future<bool> sendPasswordResetEmail(String email) async {
    return await _firebaseAuthService.sendPasswordResetEmail(email);
  }

  @override
  Future<UserInfoC?> signInWithEmailandPassword(
      String email, String password) async {
    //sifre = Hkcblc22@
    UserInfoC? userInfoC =
        await _firebaseAuthService.signInWithEmailandPassword(email, password);
    if (userInfoC != null) {
      return await _firestoreService.readUser(userInfoC.id!);
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  Future<List<Pigeon>> getPigeons() async {
    return await _firestoreService.getPigeons();
  }

  Future<bool> addPigeon(Pigeon pigeon) async {
    return await _firestoreService.addPigeon(pigeon);
  }
}
