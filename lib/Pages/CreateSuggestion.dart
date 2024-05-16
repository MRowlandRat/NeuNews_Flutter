import 'package:flutter/material.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';

class CreateInitPage extends StatefulWidget {
  const CreateInitPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateInitPage();
}

class _CreateInitPage extends State<CreateInitPage> {
  String suggestionTitle = "";
  String suggestionDescription = "";

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  dispose() {
    titleController.text = '';
    descController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'USG',
            style: TextStyle(
                color: Colors.yellow.shade600, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 90.0, 0.0),
            child: Image.asset('assets/images/Neumont_logo.png'),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: inputField(
                          "Suggestion Title", Icons.text_fields, titleController)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Description", Icons.text_fields, descController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                button(context, "Back", () {
                  Navigator.pop(context);
                }, 0, 0, 0, 0),
                button(context, "Create Initiative", () {
                  suggestionTitle = titleController.text;
                  suggestionDescription = descController.text;
                  //clears text fields
                  titleController.text = '';
                  descController.text = '';
                }, 0, 0, 0, 0)
              ],
            ),
          ],
        ));
  }
}

//body: ,
