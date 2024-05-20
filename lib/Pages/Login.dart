import 'package:flutter/material.dart';
import 'package:neunews_flutter/Pages/Register.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/ReusableWidgets/InputField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String email = "";
  String password = "";

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  dispose() {
    _emailTextController.text = '';
    _passwordTextController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 8),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: inputField("Email", Icons.mail, _emailTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: inputField(
                    "Password", Icons.lock_outline, _passwordTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
                child: button(context, "Register", () {
                  // redirect to home page
                  print("hello");
                }, 0, 0, 0, 0),
              ),
              loginInOption()
            ],
          ),
        ),
      ),
    );
  }

  Row loginInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          child: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}
