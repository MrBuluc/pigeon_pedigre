import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
import 'package:pigeon_pedigre/models/user_info.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference usersRef;
  late CollectionReference pigeonsRef;

  FirestoreService() {
    usersRef = _firestore.collection("Users").withConverter<UserInfoC>(
        fromFirestore: (snapshot, _) => UserInfoC.fromJson(snapshot.data()!),
        toFirestore: (userInfoC, _) => userInfoC.toJson());

    pigeonsRef = _firestore.collection("Pigeons").withConverter<Pigeon>(
        fromFirestore: (snapshot, _) => Pigeon.fromJson(snapshot.data()!),
        toFirestore: (pigeon, _) => pigeon.toJson());
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

  Future<List<Pigeon>> getPigeons() async {
    List<Pigeon> pigeons = [];
    QuerySnapshot<Pigeon> querySnapshot =
        (await pigeonsRef.get()) as QuerySnapshot<Pigeon>;
    for (QueryDocumentSnapshot<Pigeon> queryDocumentSnapshot
        in querySnapshot.docs) {
      pigeons.add(queryDocumentSnapshot.data());
    }
    return pigeons;
  }
}
