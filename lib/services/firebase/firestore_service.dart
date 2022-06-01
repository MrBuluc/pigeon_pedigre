import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pigeon_pedigre/models/user_info.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference usersRef;

  FirestoreService() {
    usersRef = _firestore.collection("Users").withConverter<UserInfoC>(
        fromFirestore: (snapshot, _) => UserInfoC.fromJson(snapshot.data()!),
        toFirestore: (userInfoC, _) => userInfoC.toJson());
  }

  Future<bool> setUser(UserInfoC userInfoC) async {
    try {
      await usersRef.doc(userInfoC.id).set(userInfoC);
      return true;
    } catch (e) {
      print("db setUser hata: " + e.toString());
      return false;
    }
  }

  Future<UserInfoC> readUser(String userId) async {
    return (await usersRef
        .doc(userId)
        .get()
        .then((snapshot) => snapshot.data()!)) as UserInfoC;
  }
}
