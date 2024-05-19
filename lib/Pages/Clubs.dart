import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/ClubCard.dart';
import 'package:neunews_flutter/ReusableWidgets/NeuAppBar.dart';

class Clubs extends StatefulWidget {
  const Clubs({super.key});

  @override
  State<StatefulWidget> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neuBar('Clubs'),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClubCard(
                  inactive: false,
                  admin: true,
                ),
                ClubCard(
                  inactive: false,
                  admin: true,
                ),
                ClubCard(
                  inactive: true,
                  admin: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
