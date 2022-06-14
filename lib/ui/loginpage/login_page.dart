import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/models/user_info.dart';
import 'package:pigeon_pedigre/ui/clipper.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../../app/exceptions.dart';
import '../../const.dart';
import '../../services/validator.dart';
import '../homepage/home_page.dart';
import '../registerpage/registerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email, password;

  ButtonState buttonState = ButtonState.idle;

  late UserModel _userModel;

  @override
  Widget build(BuildContext context) {
    _userModel = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: gradient,
        ),
        title: const Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  decoration: gradient,
                  height: size.height / 4,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              size: 22,
                            ),
                            labelText: "E-mail"),
                        validator: Validator.emailControl,
                        onSaved: (String? value) => email = value,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              size: 22,
                            ),
                            labelText: "Şifre"),
                        validator: Validator.passwordControl,
                        onSaved: (String? value) => password = value,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          child: Text(
                            "Şifreni mi Unuttun?",
                            style: TextStyle(
                                color: colorTwo,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _forgetPassword(context);
                          }),
                    ),
                    ProgressButton.icon(
                      state: buttonState,
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: "Giriş Yap",
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            color: colorOne),
                        ButtonState.loading:
                            IconedButton(text: "Yükleniyor", color: colorOne),
                        ButtonState.fail: IconedButton(
                            text: "Hata",
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "",
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400)
                      },
                      onPressed: () {
                        switch (buttonState) {
                          case ButtonState.idle:
                            buttonState = ButtonState.loading;
                            signInWithEmailandPassword(context);
                            break;
                          case ButtonState.loading:
                            break;
                          case ButtonState.success:
                            buttonState = ButtonState.idle;
                            break;
                          default:
                            buttonState = ButtonState.idle;
                            break;
                        }
                        setState(() {
                          buttonState = buttonState;
                        });
                      },
                    ),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Bir Hesabınız Yok mu?",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                  color: colorOne,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _forgetPassword(BuildContext context) async {
    formKey.currentState?.save();
    String? result = Validator.emailControl(email);
    if (result == "Geçersiz email") {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              headerAnimationLoop: false,
              animType: AnimType.TOPSLIDE,
              showCloseIcon: true,
              closeIcon: const Icon(Icons.close_fullscreen_outlined),
              title: 'E-posta Adresini Kontrol Et',
              desc:
                  'E-posta alanını boş bırakamazsın ve doğru formatta e-posta '
                  'girmen gerekiyor',
              btnOkOnPress: () {})
          .show();
    } else {
      try {
        bool sonuc = await _userModel.sendPasswordResetEmail(email!);
        if (sonuc) {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'E posta Kutunu Kontrol Et',
            desc:
                'Şifreni sıfırlamak için ihtiyacın olan bağlantı linki $email '
                'adresine gönderildi',
            btnOkOnPress: () {},
            btnOkIcon: Icons.check_circle,
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.WARNING,
            showCloseIcon: true,
            title: 'Şifre Sıfırlama Mailı Gönderilemedi 😕',
            desc: 'Şifre sıfırlama mailı gönderilirken bir sorun oluştu.\n'
                'İnternet bağlantınızı kontrol edin',
            btnOkOnPress: () {},
            btnOkText: "Tamam",
            btnOkIcon: Icons.check_circle,
          ).show();
        }
      } catch (e) {
        AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.WARNING,
          showCloseIcon: true,
          title: 'Şifre Sıfırlama Maili HATA',
          desc: 'Lütfen internet bağlantınızı kontrol edin',
          btnOkOnPress: () {},
          btnOkText: "Tamam",
          btnOkIcon: Icons.check_circle,
        ).show();
      }
    }
  }

  Future signInWithEmailandPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        UserInfoC? userInfoC =
            await _userModel.signInWithEmailandPassword(email!, password!);
        if (userInfoC != null) {
          setState(() {
            buttonState = ButtonState.success;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          changeButtonStateFailtoIdle();
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.WARNING,
            showCloseIcon: true,
            title: 'Kullanıcı Onaylı Değil',
            desc:
                'Lütfen e-mail adresinize gönderilen aktivasyon mailini onaylayınız',
            btnOkOnPress: () {},
            btnOkText: "Tamam",
            btnOkIcon: Icons.check_circle,
          ).show();
        }
      } catch (e) {
        changeButtonStateFailtoIdle();
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: 'Hay Aksi!',
                desc: Exceptions.goster(e.toString()),
                btnOkOnPress: () {},
                btnOkText: "Tamam",
                btnOkIcon: Icons.cancel,
                btnOkColor: Colors.red)
            .show();
      }
    } else {
      changeButtonStateFailtoIdle();
    }
  }

  Future changeButtonStateFailtoIdle() async {
    setState(() {
      buttonState = ButtonState.fail;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      buttonState = ButtonState.idle;
    });
  }
}
