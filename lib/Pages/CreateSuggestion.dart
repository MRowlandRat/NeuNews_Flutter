import 'package:flutter/material.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';

class CreateSuggestionPage extends StatefulWidget {
  const CreateSuggestionPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateSuggestionPage();
}

class _CreateSuggestionPage extends State<CreateSuggestionPage> {
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
        appBar: neuBar('Create Suggestion'),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: inputField(
                          "Suggestion Title", Icons.title, titleController)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Suggestion Description", Icons.description, descController),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create Suggestion", () {
                      suggestionTitle = titleController.text;
                      suggestionDescription = descController.text;
                      //clears text fields
                      dispose();
                    }, 0, 0, 0, 0)
                ),

              ],
            ),
          ],
        )
    );
  }
}
