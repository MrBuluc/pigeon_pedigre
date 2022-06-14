import 'package:flutter/material.dart';
import 'package:pigeon_pedigre/ui/homepage/home_page.dart';
import 'package:pigeon_pedigre/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../ui/loginpage/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    if (_userModel.state == ViewState.idle) {
      if (_userModel.userC == null) {
        return const LoginPage();
      } else {
        return const HomePage();
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
