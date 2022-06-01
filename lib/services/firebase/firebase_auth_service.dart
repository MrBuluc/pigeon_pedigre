import 'package:firebase_auth/firebase_auth.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserInfoC> createUserWithEmailandPassword(
      String name, String surname, String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return UserInfoC(
        id: userCredential.user!.uid,
        mail: email,
        name: name,
        surname: surname);
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
