import 'package:flutter/material.dart';

class AddPigeonPage extends StatefulWidget {
  const AddPigeonPage({Key? key}) : super(key: key);

  @override
  State<AddPigeonPage> createState() => _AddPigeonPageState();
}

class _AddPigeonPageState extends State<AddPigeonPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Add Pigeon Page"),
    );
  }
}
