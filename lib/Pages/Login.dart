import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:neunews_flutter/Pages/Register.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/ReusableWidgets/InputField.dart';
import 'package:neunews_flutter/ReusableWidgets/ValidationInputField.dart';
import 'package:neunews_flutter/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _email = "";
  String _password = "";
  String _hashedpassword = "";

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: inputField("Email", Icons.mail, _emailTextController),
              ),
              validationInputField(
                  "Password",
                  Icons.lock_outline,
                  _passwordTextController,
                  TextInputType.text,
                  "Password",
                  true),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
                child: button(context, "Login", () {
                  _email = _emailTextController.text;
                  _password = _passwordTextController.text;
                  //verify user exists
                  //check if passwords match
                  _hashedpassword = hashPassword(_password);
                  // if (_hashedpassword == {USER OBJECT PASSWORD})
                  {
                    // redirect to home page
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: "Neu News")));
                  }

                  print("hello");
                }, 0, 0, 0, 0),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: loginOption())
            ],
          ),
        ),
      ),
    );
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Hash the password

    return digest.toString(); // Convert the hash to a hexadecimal string
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          child: const Text(
            "Register",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);

  return digest.toString();
}