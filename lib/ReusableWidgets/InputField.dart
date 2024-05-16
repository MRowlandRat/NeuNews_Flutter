import 'package:flutter/material.dart';

TextFormField inputField(
    String labelText, IconData iconData, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
    cursorColor: Colors.amber,
    decoration: InputDecoration(
      prefixIcon: Icon(
        iconData,
        color: Colors.amber,
      ),
      labelText: labelText,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      ),
    ),
    keyboardType: TextInputType.text,
  );
}