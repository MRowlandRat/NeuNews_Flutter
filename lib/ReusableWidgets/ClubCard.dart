import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neunews_flutter/Models/Club.dart';
import 'package:neunews_flutter/ReusableWidgets/AdminButton.dart';
import 'package:http/http.dart' as http;

class ClubCard extends StatefulWidget {
  const ClubCard({super.key, required this.club, required this.admin});

  final Club club;
  final bool admin;

  @override
  State<StatefulWidget> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  late Widget descriptionWidget;
  late Widget nameWidget;
  late Widget approvalWidget;
  bool inactive = true;
  String btnTxt = 'Edit';
  TextEditingController clubDesCon = new TextEditingController();
  TextEditingController clubNameCon = new TextEditingController();

  void updateCheck(bool val) {
    setState(() {
      inactive = val;
      widget.club.clubInactive = val.toString();
    });
  }

  Future<void> _updateClub() async {
    setState(() async {
      widget.club.clubInactive = inactive.toString();
      widget.club.clubName = clubNameCon.text;
      widget.club.clubDescription = clubDesCon.text;
      var body = json.encode(widget.club.toJson());
      await http.post(
          Uri.parse(
              "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Clubs/UpdateClub.php/${widget.club.clubId}"),
          body: body);
      print(widget.club.toJson());
    });
  }

  Future<void> _deleteClub() async {
    setState(() async {
      await http.delete(Uri.parse(
          "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Clubs/DeleteClub.php/${widget.club.clubId}"));
    });
  }

  void editMode(String mode) {
    if (mode == 'Edit') {
      setState(() {
        btnTxt = 'Save';
        descriptionWidget = Column(
          children: [
            TextField(
              controller: clubDesCon,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                ),
                hintText: widget.club.clubDescription,
              ),
            ),
            TextField(
              controller: clubNameCon,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                ),
                hintText: widget.club.clubName,
              ),
            ),
          ],
        );
        approvalWidget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Checkbox(
              checkColor: Colors.amber,
              fillColor: WidgetStateProperty.all(Colors.white),
              value: inactive,
              onChanged: (val) {
                updateCheck(val!);
              },
            ),
            Text(
              inactive ? 'Inactive' : 'Active',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: inactive ? Colors.red : Colors.green),
            ),
          ],
        );
      });
    } else if (mode == 'Save') {
      setState(() {
        _updateClub();
        btnTxt = 'Edit';
        widget.club.clubDescription = clubDesCon.text;
        clubDesCon.text = '';
        descriptionWidget = Text(
          widget.club.clubDescription,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
        );
        widget.club.clubName = clubNameCon.text;
        clubNameCon.text = '';
        nameWidget = Text(
          widget.club.clubName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
        );
        approvalWidget = Text(
          inactive ? 'Inactive' : 'Active',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: inactive ? Colors.red : Colors.green),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.club.clubInactive == 'true' ? inactive = true : inactive = false;
    descriptionWidget = Text(
      widget.club.clubDescription,
      style: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
    );
    nameWidget = Text(
      widget.club.clubName,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
    );
    approvalWidget = Text(
      inactive ? 'Inactive' : 'Active',
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: inactive ? Colors.red : Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: nameWidget,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: approvalWidget,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 90,
                width: 90,
                child: Image.network(widget.club.clubImage),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: descriptionWidget,
              ),
            ),
            widget.admin
                ? Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AdminButton(
                            label: btnTxt,
                            labelColor: Colors.green,
                            action: () {
                              if (btnTxt == 'Save') {
                                editMode('Save');
                              } else {
                                editMode('Edit');
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AdminButton(
                            label: 'Delete',
                            labelColor: Colors.red,
                            action: () {
                              _deleteClub();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }
}
