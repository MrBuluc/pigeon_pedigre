import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/const.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/services/validator.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../../app/exceptions.dart';
import '../../common_widget/password_tool_tip.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name, surname, mail, password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showToolTip = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Kayıt Ol"),
        flexibleSpace: Container(
          decoration: gradient,
        ),
        elevation: 2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Kayıt olmak için formu doldurunuz.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: TextFormField(
                          decoration: generateInputDecoration("Ad"),
                          validator: Validator.nameControl,
                          onSaved: (String? value) => name = value?.trim(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: TextFormField(
                          decoration: generateInputDecoration("Soyad"),
                          validator: Validator.surnameControl,
                          onSaved: (String? value) => surname = value,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: TextFormField(
                          decoration: generateInputDecoration("E-posta"),
                          validator: Validator.emailControl,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? value) => mail = value,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 7),
                        child: TextFormField(
                          obscureText: true,
                          decoration: generateInputDecoration("Şifre").copyWith(
                              suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.error,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showToolTip = !showToolTip;
                              });
                            },
                          )),
                          validator: Validator.passwordControl,
                          onSaved: (String? value) => password = value,
                        ),
                      ),
                      showToolTip ? const PasswordToolTip() : Container(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        width: size.width,
                        decoration: gradient,
                        child: TextButton(
                          child: const Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _generateNewUser(context);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Zaten Hesabın var mı?"),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(color: Color(0xff22A45D)),
                            ),
                            onTap: () => Navigator.of(context).pop(false),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration generateInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[100]);
  }

  Future _generateNewUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        showCloseIcon: true,
        title: "Üye Kayıt Ediliyor...",
        desc: "Üye kayıt edilirken lütfen bekleyiniz",
        btnOkOnPress: () {},
        btnOkText: "Tamam",
      ).show();

      UserModel _userModel = Provider.of<UserModel>(context, listen: false);
      try {
        UserInfoC? userInfo = await _userModel.createUserWithEmailandPassword(
            name!, surname!, mail!, password!);
        if (userInfo != null) {
          Navigator.pop(context);
          AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.RIGHSLIDE,
                  headerAnimationLoop: true,
                  title: "Kaydınız Başarıyla Gerçekleştirildi 👍",
                  desc:
                      "Giriş ekranına dönerek e-posta adresiniz ve şifreniz ile "
                      "giriş yapabilirsiniz",
                  btnOkOnPress: () {
                    Navigator.pop(context);
                  },
                  btnOkText: "Tamam",
                  btnOkColor: Colors.green)
              .show();
        } else {
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            showCloseIcon: true,
            title: "Üye Kayıt Edilirken HATA 😕",
            desc: "Üye kayıt edilirken bir sorun oluştu.\n"
                "Lütfen internet bağlantınızı kontrol edin",
            btnOkOnPress: () {},
            btnOkText: "Tamam",
          ).show();
        }
      } on FirebaseAuthException {
        Navigator.pop(context);
        AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: "Bu hesap kullanımda",
                desc: "Bu e-posta ile ilişkili bir hesap bulunmaktadır",
                btnOkOnPress: () {},
                btnOkText: "Tamam",
                btnOkIcon: Icons.cancel,
                btnOkColor: Colors.red)
            .show();
      } catch (e) {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          showCloseIcon: true,
          title: "",
          desc: Exceptions.goster(e.toString()),
          btnOkOnPress: () {},
          btnOkText: "Tamam",
        ).show();
      }
    } else {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.RIGHSLIDE,
              headerAnimationLoop: true,
              title: "Değerleri Doğru Giriniz",
              desc: "Lütfen istenilen değerleri tam ve doğru giriniz",
              btnOkOnPress: () {},
              btnOkText: "Tamam",
              btnOkColor: Colors.blue)
          .show();
    }
  }
}
