import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/common_widget/drawer/drawerC.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
import 'package:pigeon_pedigre/ui/pigeons/detail_page.dart';

import '../pigeons/add_pigeon_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> pigeonsStream =
      FirebaseFirestore.instance.collection("Pigeons").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pigeons"),
        centerTitle: true,
      ),
      drawer: const DrawerC(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPigeonPage()));
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: pigeonsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loaing");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data["id"]),
                leading: const Icon(Icons.flutter_dash),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(pigeon: Pigeon.fromJson(data))));
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
