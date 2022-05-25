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
