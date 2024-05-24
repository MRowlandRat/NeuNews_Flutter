import 'package:flutter/material.dart';

TextFormField usernameInputField(
    String labelText, IconData iconData, TextEditingController controller) {
  return TextFormField(
    textCapitalization: TextCapitalization.sentences,
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
    obscureText: false,
    cursorColor: Colors.amber,
    decoration: InputDecoration(
      prefixIcon: Icon(
        iconData,
        color: Colors.black,
      ),
      labelText: labelText,
      // filled: true,
      // floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.amber, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.black, width: 1.0),
      ),
    ),
    keyboardType: TextInputType.text,
  );
}

bool isValidUsername(String input){
  final RegExp usernameRegex = RegExp(
      r'^[A-Za-z0-9.\-_!#^~]{1,64}@[A-Za-z0-9.\-_!#^~]{1,48}$'
  );
  return usernameRegex.hasMatch(input);
}