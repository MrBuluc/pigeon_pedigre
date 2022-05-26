import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/locator.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'app/landing_page.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "Pigeon Pedigre";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: true,
        home: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("snapshot.error: " + snapshot.error.toString());
            print("snapshot.stackTrace: " + snapshot.stackTrace.toString());
            return Scaffold(
              body: Center(
                child: Text("Hata çıktı: " + snapshot.error.toString()),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const LandingPage();
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
