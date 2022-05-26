import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/ui/clipper.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../services/validator.dart';

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
        title: Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 25),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
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
                          padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  size: 22,
                                ),
                                labelText: "Şifre"),
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
                            onPressed: () {},
                          ),
                        ),
                        ProgressButton.icon(
                          state: buttonState,
                          iconedButtons: {
                            ButtonState.idle: IconedButton(
                                text: "Giriş Yap",
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                color: colorOne),
                            ButtonState.loading: IconedButton(
                                text: "Yükleniyor", color: colorOne),
                            ButtonState.fail: IconedButton(
                                text: "Hata",
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                                color: Colors.red.shade300),
                            ButtonState.success: IconedButton(
                                text: "",
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                color: Colors.green.shade400)
                          },
                          onPressed: () {},
                        ),
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
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
                                onPressed: () {},
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
