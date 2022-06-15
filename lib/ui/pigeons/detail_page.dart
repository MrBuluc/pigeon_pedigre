import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Pigeon pigeon;
  const DetailPage({Key? key, required this.pigeon}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Pigeon pigeon;

  @override
  void initState() {
    super.initState();
    pigeon = widget.pigeon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Pigeon Family",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Color(0xFFEBAEAB)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getPigeonInfo(const Color(0xFFFF00F8), "Mom", pigeon.momId!),
                  getPigeonInfo(const Color(0xFF112A8F), "Dad", pigeon.dadId!),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getPigeonInfo(const Color(0xFFFFD600), "Itself", pigeon.id!)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPigeonInfo(Color borderColor, String familyName, String id) {
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: borderColor, width: 5)),
            child: Image.asset(
              "assets/pigeon.jpg",
              width: 140,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            familyName,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            id,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
      onTap: () => goToDetailPage(id),
    );
  }

  Future goToDetailPage(String id) async {
    if (id != pigeon.id) {
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
      Pigeon? parentPigeon = await userModel.getPigeon(id);
      if (parentPigeon != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(pigeon: parentPigeon)));
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: 'Pigeon Not Found!',
                desc:
                    'You are trying to reach the family of a pigeon that is not in our system.\n'
                    'You can add if you want.',
                btnOkOnPress: () {},
                btnOkText: "Ok",
                btnOkColor: Colors.blue)
            .show();
      }
    }
  }
}
