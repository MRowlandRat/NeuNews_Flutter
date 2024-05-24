import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/AdminButton.dart';

class ClubCard extends StatefulWidget {
  ClubCard({super.key, required this.inactive, required this.admin});

  late bool inactive;

  final bool admin;

  @override
  State<StatefulWidget> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  late Widget descriptionWidget;
  late Widget nameWidget;
  late Widget approvalWidget;
  String clubDes =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';
  String modeTxt = "Edit";
  String clubName = 'Club';
  TextEditingController clubDesCon = new TextEditingController();
  TextEditingController clubNameCon = new TextEditingController();

  void updateCheck(bool val) {
    setState(() {
      widget.inactive = val;
    });
  }

  void editMode(String mode) {
    if (mode == 'edit') {
      setState(() {
        modeTxt = "Save";
        descriptionWidget = Column(
          children: [
            TextField(
              controller: clubDesCon,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                ),
                hintText: clubDes,
              ),
            ),
            TextField(
              controller: clubNameCon,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.brown, width: 2.0),
                ),
                hintText: clubName,
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
              value: widget.inactive,
              onChanged: (val) {
                updateCheck(val!);
              },
            ),
            Text(
              widget.inactive ? 'Inactive' : 'Active',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: widget.inactive ? Colors.red : Colors.green),
            ),
          ],
        );
      });
    } else if (mode == 'display') {
      setState(() {
        modeTxt = "Edit";
        clubDes = clubDesCon.text;
        clubDesCon.text = '';
        descriptionWidget = Text(
          clubDes,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
        );
        clubName = clubNameCon.text;
        clubNameCon.text = '';
        nameWidget = Text(
          clubName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
        );
        approvalWidget = Text(
          widget.inactive ? 'Inactive' : 'Active',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: widget.inactive ? Colors.red : Colors.green),
        );
      });
    }
  }

  @override
  void initState() {
    descriptionWidget = Text(
      clubDes,
      style: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
    );
    nameWidget = Text(
      clubName,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
    );
    approvalWidget = Text(
      widget.inactive ? 'Inactive' : 'Active',
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: widget.inactive ? Colors.red : Colors.green),
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
                child: Image.asset('assets/images/Neumont_logo.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: descriptionWidget,
              ),
            ),
            widget.admin ?Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AdminButton(
                      label: modeTxt,
                      labelColor: Colors.green,
                      action: () {
                        if (modeTxt == 'Edit') {
                          editMode('edit');
                        } else {
                          editMode('display');
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
                        print('Delete');
                      },
                    ),
                  ),
                ],
              ),
            ) : Text('')




          ],
        ),
      ),
    );
  }
}
