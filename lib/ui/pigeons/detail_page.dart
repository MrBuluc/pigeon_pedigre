import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';

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
    if (id != pigeon.id) {}
  }
}
