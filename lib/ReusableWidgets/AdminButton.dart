import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  const AdminButton(
      {super.key,
      required this.label,
      required this.labelColor,
      required this.action});

  final String label;
  final Color labelColor;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.amber,
      onTap: () {
        action();
      },
      child: Container(
        height: 40,
        width: 80,
        child: Card(
            color: Colors.amberAccent,
            elevation: 8,
            shadowColor: Colors.black,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style:
                    TextStyle(color: labelColor, fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
