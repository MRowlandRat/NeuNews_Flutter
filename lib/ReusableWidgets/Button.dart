import 'package:flutter/material.dart';

Container button(BuildContext context, String buttonText,
    Function onClick, double L, double T, double R, double B) {
  return Container(
    alignment: Alignment.centerRight,
    width: 200,
    height: 50,
    margin: EdgeInsets.fromLTRB(L, T, R, B),
    // margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
    child: ElevatedButton(
      onPressed: () {
        onClick();
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            }
            return Colors.black;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
      child: Text(buttonText),
    ),
  );
}
