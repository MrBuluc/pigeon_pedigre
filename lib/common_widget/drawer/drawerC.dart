import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/const.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/ui/clipper.dart';
import 'package:pigeon_pedigre/ui/pigeons/add_pigeon_page.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../../ui/loginpage/login_page.dart';

class DrawerC extends StatefulWidget {
  const DrawerC({Key? key}) : super(key: key);

  @override
  State<DrawerC> createState() => _DrawerCState();
}

class _DrawerCState extends State<DrawerC> {
  String name = " ", surname = " ", mail = "";

  late UserModel userModel;

  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<UserModel>(context, listen: false);
    currentUser();
    return Drawer(
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Center(
                  child: SizedBox(
                    height: 230,
                    child: DrawerHeader(
                      decoration: gradient,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: Theme.of(context).platform ==
                                      TargetPlatform.iOS
                                  ? Colors.red
                                  : const Color.fromRGBO(117, 138, 230, 1),
                              child: Text(
                                name[0] + surname[0],
                                style: const TextStyle(
                                    fontSize: 35, color: Colors.black54),
                              ),
                            ),
                            Text(
                              mail,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              name + " " + surname,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                leading: const Icon(Icons.flutter_dash),
                title: const Text("Pigeons"),
                trailing: const Icon(Icons.arrow_drop_down),
                children: [
                  ListTile(
                    title: const Text("Add Pigeon"),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPigeonPage()));
                    },
                  )
                ],
              ),
              const Expanded(child: SizedBox()),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      _areYouSureForSignOut(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      "Çıkış Yap",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    onPressed: () {
                      _areYouSureForSignOut(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future currentUser() async {
    UserInfoC? userInfoC = userModel.userC;
    if (userInfoC != null) {
      setState(() {
        name = userInfoC.name!;
        surname = userInfoC.surname!;
        mail = userInfoC.mail!;
      });
    }
  }

  Future _areYouSureForSignOut(BuildContext context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Emin Misin?',
      desc: 'Oturumunu kapatmak istediğine emin misin?',
      btnCancelText: "Vazgeç",
      btnCancelOnPress: () {},
      btnOkText: "Evet",
      btnOkOnPress: () {
        _cikisYap(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    ).show();
  }

  Future _cikisYap(BuildContext context) async {
    try {
      await userModel.signOut();
    } catch (e) {
      print("sign out hata: " + e.toString());
    }
  }
}
