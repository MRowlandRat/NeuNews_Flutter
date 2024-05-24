import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:neunews_flutter/Pages/Register.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import 'package:neunews_flutter/ReusableWidgets/InputField.dart';
import 'package:neunews_flutter/ReusableWidgets/ValidationInputField.dart';
import 'package:neunews_flutter/main.dart';
import 'package:http/http.dart' as http;

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
                child: validationInputField("Email", Icons.mail, _emailTextController, TextInputType.emailAddress, false),
              ),
              validationInputField(
                  "Password",
                  Icons.lock_outline,
                  _passwordTextController,
                  TextInputType.text,
                  true),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
                child: button(context, "Login", () async {
                  _email = _emailTextController.text;
                  _password = _passwordTextController.text;
                  _hashedpassword = hashPassword(_password);
                  if (await loginUser(_email, _password)){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: "Neu News")));
                  } else {
                      showSnackBar(context, "Invalid username or password");
                  }
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

Future<bool> loginUser(String email, String password) async {
    String userId = "";
    //verify user exists through a get by email(?)
    var url = Uri.http('192.168.1.11:2024', '/api/Users/LoginUser.php');
    var response = await http.post(url, body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      userId = response.body;
    } else {
      print('Failed to login: ${response.statusCode}');
    }
    if (userId != "") {
      //set session
      return true;
    } else {
      // Password or Email is not valid
      return false;
    }
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
