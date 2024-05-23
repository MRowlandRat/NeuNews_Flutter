import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:neunews_flutter/Pages/Login.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/ReusableWidgets/InputField.dart';
import 'package:neunews_flutter/ReusableWidgets/ValidationInputField.dart';
import 'package:neunews_flutter/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String _email = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = '';

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  dispose() {
    _emailTextController.text = '';
    _nameTextController.text = '';
    _passwordTextController.text = '';
    _confirmPasswordTextController.text = '';
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
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: validationInputField(
                    "Email",
                    Icons.mail,
                    _emailTextController,
                    TextInputType.emailAddress,
                    "Email",
                    false),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: inputField(
                    "Username", Icons.account_circle, _nameTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: validationInputField(
                    "Password",
                    Icons.lock_outline,
                    _passwordTextController,
                    TextInputType.text,
                    "Password",
                    true),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: validationInputField(
                    "Confirm Password",
                    Icons.lock,
                    _confirmPasswordTextController,
                    TextInputType.text,
                    "Password",
                    true),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
                child: button(context, "Register", () {
                  String email = _emailTextController.text;
                  String username = _nameTextController.text;
                  String password = _passwordTextController.text;
                  String confirmPassword = _confirmPasswordTextController.text;
                  createUser(context, email, username, password, confirmPassword);
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

  void createUser(BuildContext context, String email, String name, String password, String confirmPassword) {
    if (validateInput(context, email, name, password)) {
      if (password == confirmPassword) {
        //hash password
        password = hashPassword(password);
        // create user by hitting the API
        //create session with user data (id, username, email)
        // redirect to home page
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Neu News")));
      } else {
        showErrorMessage(context, 'Passwords must match!');
      }
    }
  }

  bool validateInput(BuildContext context, String email, String name, String password) {
    if (email.isEmpty || name.isEmpty || password.isEmpty) return false;
    if (!isValidEmail(email)) {
      showErrorMessage(context, 'Please enter a valid email!');
      return false;
    }
    if (!isValidUsername(name)) {
      showErrorMessage(context, 'Please enter a valid username!');
      return false;
    }
    if (!isValidPassword(password)) {
      showErrorMessage(context,
          'Passwords must contain at least one Uppercase letter, one Lowercase letter, one Numeric character and one Special character!');
      return false;
    }
    return true;
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }


  bool isValidPassword(String input) {
    final RegExp passwordRegex = RegExp(
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#\$&*~]).{8,}$");
    bool isValid = passwordRegex.hasMatch(input);
    return isValid;
  }

  bool isValidEmail(String input) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    bool isValid = emailRegex.hasMatch(input);
    return isValid;
  }

  bool isValidUsername(String input) {
    final RegExp usernameRegex = RegExp(r"^[A-Za-z0-9._-]{4,}$");
    bool isValid = usernameRegex.hasMatch(input);
    return isValid;
  }

  void showErrorMessage(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text("Login",
              style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
