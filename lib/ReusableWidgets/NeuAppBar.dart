import 'package:flutter/material.dart';
NeuBar() {
  return AppBar(
    title: const Text(
      'Neu News',
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: Colors.amber,
    centerTitle: true,
    flexibleSpace: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 160.0, 0.0),
      child: Image.asset('assets/images/Neumont_logo.png'),
    ),
  );
}