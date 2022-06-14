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
  Future<UserInfoC?> currentUser() {
    try {
      User? user = _firebaseAuth.currentUser;
      return Future.value(_userFromFirebase(user));
    } catch (e) {
      print("Firebase HATA CURRENT USER: " + e.toString());
      return Future.value(null);
    }
  }

  UserInfoC? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return UserInfoC(id: user.uid, mail: user.email, name: user.displayName);
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("firebase sendPasswordResetEmail hata: " + e.toString());
      rethrow;
    }
    return true;
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
