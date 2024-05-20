import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/Button.dart';
import 'package:neunews_flutter/ReusableWidgets/InputField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String email = "";
  String password = "";
  String confirmPassword = '';

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  @override
  dispose() {
    _emailTextController.text = '';
    _passwordTextController.text = '';
    _confirmPasswordTextController.text = '';
    super.dispose();
  }

  //controllers here
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
                child: inputField(
                    "Email", Icons.mail, _emailTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: inputField(
                    "Username", Icons.account_circle, _emailTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: inputField("Password", Icons.lock_outline, _passwordTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: inputField("Confirm Password", Icons.lock, _confirmPasswordTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 10, 0, 0),
                child: button(context, "Register", () {
                  if (_passwordTextController.text == _confirmPasswordTextController.text) {
                    // create user
                    // redirect to home page
                    print("hello");
                  } else {}
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
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const LoginWidget()));
          },
          child: const Text("Login"),
        )
      ],
    );
  }
}
