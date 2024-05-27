import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/Pages/Login.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/Session.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  var sessionManager = SessionManagerSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: button(context, "Logout", () async {
        await sessionManager.clearSessionValue("user");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }, 0, 0, 100, 0),
    ));
  }
}
