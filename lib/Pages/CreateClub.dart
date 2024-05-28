import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';
import 'package:http/http.dart' as http;

class CreateClubPage extends StatefulWidget {
  const CreateClubPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateClubPage();
}

class _CreateClubPage extends State<CreateClubPage> {
  String _name = "";
  String _description = "";
  // clubImage will be an image upload later once S3 bucket is set up, for now it's just a URL
  String _imageURL = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  dispose() {
    nameController.text = '';
    descController.text = '';
    imageController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: neuBar('Create Club'),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: inputField(
                          "Club name", Icons.edit, nameController)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Club description", Icons.description, descController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Club Image URL", Icons.image, imageController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create News", () async {
                      _name = nameController.text;
                      _description = descController.text;
                      _imageURL = imageController.text;
                      if (_name.isEmpty || _description.isEmpty || _imageURL.isEmpty)
                        {
                          showSnackBar(context, "Please fill out all fields!");
                        }
                      else
                        {
                          await CreateClub().whenComplete(() {
                            Navigator.pop(context);
                          });
                        }
                    }, 0, 0, 0, 0)
                ),
              ],
            ),
          ],
        ),
    );
  }

  Future<void> CreateClub() async {
    Map data = {
      "name": _name,
      "description": _description,
      "image": _imageURL
    };
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(
        Uri.parse(
            "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Suggestions/CreateSuggestion.php"),
        body: body);
  }
}
