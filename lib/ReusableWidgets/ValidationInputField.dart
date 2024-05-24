import 'package:flutter/material.dart';

TextFormField validationInputField(
    String labelText,
    IconData iconData,
    TextEditingController controller,
    TextInputType inputType,
    bool obscureText) {
  return TextFormField(
    textCapitalization: TextCapitalization.sentences,
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
    obscureText: obscureText,
    cursorColor: Colors.amber,
    decoration: InputDecoration(
      prefixIcon: Icon(
        iconData,
        color: Colors.black,
      ),
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.amber, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.black, width: 1.0),
      ),
    ),
    keyboardType: inputType,
  );
}

bool isValidPassword(String input) {
  final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{12,}$');
  return passwordRegex.hasMatch(input);
}

bool isValidEmail(String input) {
  final RegExp emailRegex =
      RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
  return emailRegex.hasMatch(input);
}

bool isValidUsername(String input) {
  final RegExp usernameRegex =
      RegExp(r'^[A-Za-z0-9.\-_!#^~]{1,64}@[A-Za-z0-9.\-_!#^~]{1,48}$');
  return usernameRegex.hasMatch(input);
}
