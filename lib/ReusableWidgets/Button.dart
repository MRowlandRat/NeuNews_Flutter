import 'package:flutter/material.dart';

Container button(BuildContext context, String buttonText,
    Function onClick, double L, double T, double R, double B) {
  return Container(
    alignment: Alignment.centerRight,
    width: MediaQuery.of(context).size.width/2,
    height: 40,
    margin: EdgeInsets.fromLTRB(L, T, R, B),
    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
    child: ElevatedButton(
      onPressed: () {
        onClick();
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black;
            }
            return Colors.amberAccent;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)))),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
