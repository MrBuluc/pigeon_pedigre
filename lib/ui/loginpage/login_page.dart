import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/ui/clipper.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 22,
                                ),
                                labelText: "E-mail"),
                            validator: Validator.emailControl,
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
