import 'package:flutter/material.dart';

TextFormField inputField(
    String labelText, IconData iconData, TextEditingController controller) {
  return TextFormField(
    textCapitalization: TextCapitalization.sentences,
    controller: controller,
    enableSuggestions: true,
    autocorrect: true,
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
    keyboardType: TextInputType.text,
  );
}