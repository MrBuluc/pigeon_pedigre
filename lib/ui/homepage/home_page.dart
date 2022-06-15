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
  Stream<QuerySnapshot> pigeonsStream =
      FirebaseFirestore.instance.collection("Pigeons").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Search...",
                  ),
                  onChanged: (String searchId) => search(searchId),
                ),
              )),
          Expanded(
            flex: 10,
            child: StreamBuilder<QuerySnapshot>(
              stream: pigeonsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loaing");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
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
          ),
        ],
      ),
    );
  }

  search(String searchId) {
    if (searchId.isNotEmpty) {
      pigeonsStream = FirebaseFirestore.instance
          .collection("Pigeons")
          .where("id", isEqualTo: searchId)
          .snapshots();
    } else {
      pigeonsStream =
          FirebaseFirestore.instance.collection("Pigeons").snapshots();
    }
    setState(() {});
  }
}
