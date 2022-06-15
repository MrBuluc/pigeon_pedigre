import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/const.dart';
import 'package:pigeon_pedigre/models/pigeon.dart';
import 'package:pigeon_pedigre/services/validator.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../../app/exceptions.dart';

class AddPigeonPage extends StatefulWidget {
  const AddPigeonPage({Key? key}) : super(key: key);

  @override
  State<AddPigeonPage> createState() => _AddPigeonPageState();
}

class _AddPigeonPageState extends State<AddPigeonPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController momIdController = TextEditingController();
  TextEditingController dadIdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    momIdController.dispose();
    dadIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: gradient,
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: gradient,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 15, bottom: 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "My Pigeon's Info",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        getTextFormField(idController, "ID", top: 15),
                        getTextFormField(momIdController, "Mom ID"),
                        getTextFormField(dadIdController, "Dad ID"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: OutlinedButton(
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Color.fromRGBO(172, 182, 229, 1),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => save(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTextFormField(TextEditingController controller, String labelText,
      {double top = 0}) {
    return Container(
      padding: EdgeInsets.only(top: top, left: 15, right: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText, prefixIcon: const Icon(Icons.flutter_dash)),
        validator: Validator.nullControl,
      ),
    );
  }

  Future save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.RIGHSLIDE,
              headerAnimationLoop: true,
              title: "Pigeon's Info Saving...",
              desc: "While Pigeon's info saving, please wait",
              btnOkOnPress: () {},
              btnOkText: "Ok",
              btnOkColor: Colors.blue)
          .show();

      try {
        UserModel userModel = Provider.of<UserModel>(context, listen: false);
        bool sonuc = await userModel.addPigeon(Pigeon(
            id: idController.text,
            momId: momIdController.text,
            dadId: dadIdController.text));
        if (sonuc) {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Pigeon Addition Completed Successfully. 👍',
            desc: '🤟',
            btnOkText: "Ok",
            btnOkColor: Colors.blue,
            btnOkOnPress: () {},
          ).show();
        } else {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error Adding Pigeon. 😕',
            desc: 'There was a problem adding pigeons.\n'
                'Please check your internet connection.',
            btnOkText: "Ok",
            btnOkColor: Colors.blue,
            btnOkOnPress: () {},
          ).show();
        }
      } catch (e) {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error Adding Pigeon. 😕',
          desc: Exceptions.goster(e.toString()),
          btnOkText: "Ok",
          btnOkColor: Colors.blue,
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Enter Values Correctly',
        desc: 'Please enter the desired values completely and correctly.',
        btnOkText: "Ok",
        btnOkColor: Colors.blue,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
