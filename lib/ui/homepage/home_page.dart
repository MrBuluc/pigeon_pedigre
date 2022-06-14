import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/common_widget/drawer/drawerC.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../pigeons/add_pigeon_page.dart';

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
      body: FutureBuilder(
        future: getPigeons(),
        builder: (BuildContext context, _) {
          if (pigeons.isEmpty) {
            return const Center(
              child: Text(
                "There is not any Pigeon on the db.\n"
                "You can add Pigeon from Drawer or FAB",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView(
              children: pigeons
                  .map((pigeon) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: const Icon(Icons.flutter_dash),
                          title: Text(pigeon.id!),
                        ),
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  Future getPigeons() async {
    UserModel userModel = Provider.of<UserModel>(context, listen: false);
    pigeons = await userModel.getPigeons();
  }
}
