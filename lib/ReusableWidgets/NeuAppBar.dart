import 'package:flutter/material.dart';
AppBar neuBar(String title) {
  return AppBar(
    title: Text(
      textAlign: TextAlign.end,
      title,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: Colors.amber,
    centerTitle: true,
    leading: Container(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Image.asset('assets/images/Neumont_logo.png'),
    ),
  );
}