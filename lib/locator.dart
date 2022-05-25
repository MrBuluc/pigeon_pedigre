import 'package:get_it/get_it.dart';
import 'package:pigeon_pedigre/repository/user_repository.dart';
import 'package:pigeon_pedigre/services/firebase/firebase_auth_service.dart';
import 'package:pigeon_pedigre/services/firebase/firestore_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreService());
}
