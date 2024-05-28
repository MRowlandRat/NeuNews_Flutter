import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';
import 'package:http/http.dart' as http;

class CreateSuggestionPage extends StatefulWidget {
  const CreateSuggestionPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateSuggestionPage();
}

class _CreateSuggestionPage extends State<CreateSuggestionPage> {
  String _title = "";
  String _description = "";

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
            Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: inputField(
                    "Suggestion Title", Icons.title, titleController)),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: inputField(
                  "Suggestion Description", Icons.description, descController),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create Suggestion", () async {
                      _title = titleController.text;
                      _description = descController.text;
                      if (_title.isEmpty || _description.isEmpty) {
                        showSnackBar(context, "Fields cannot be left empty!");
                      } else {
                        await CreateSuggestions().whenComplete(() {
                          Navigator.pop(context);
                        });
                      }
                    }, 0, 0, 0, 0)),
              ],
            ),
          ],
        ),
    );
  }

  Future<void> CreateSuggestions() async {
    Map data = {"title": _title, "description": _description};
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(
        Uri.parse(
            "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Suggestions/CreateSuggestion.php"),
        body: body);
  }
}
