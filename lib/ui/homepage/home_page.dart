import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/common_widget/drawer/drawerC.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pigeon> pigeons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pigeons"),
        centerTitle: true,
      ),
      drawer: const DrawerC(),
      body: FutureBuilder(
        future: getPigeons(),
        builder: (BuildContext context, _) {
          return const Center(
            child: Text("Pigeons"),
          );
        },
      ),
    );
  }

  Future getPigeons() async {}
}
