import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';
import 'package:http/http.dart' as http;

class CreateNewsPage extends StatefulWidget {
  const CreateNewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateNewsPage();
}

class _CreateNewsPage extends State<CreateNewsPage> {
  String _title = "";
  String _description = "";

  // newsImage will be an image upload later once S3 bucket is set up, for now it's just a URL
  String _imageURL = "";
  String _location = "";
  String _time = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  dispose() {
    nameController.text = '';
    descController.text = '';
    imageController.text = '';
    locationController.text = '';
    timeController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neuBar('Create News'),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: inputField("Title", Icons.title, nameController)),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child:
                  inputField("Description", Icons.description, descController),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: inputField("Image URL", Icons.image, imageController),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: inputField("Location", Icons.map, locationController),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: inputField("Time", Icons.watch_later, timeController),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create News", () async {
                      _title = nameController.text;
                      _description = descController.text;
                      _imageURL = imageController.text;
                      _time = timeController.text;
                      _location = locationController.text;
                      if (_title.isEmpty ||
                          _description.isEmpty ||
                          _imageURL.isEmpty ||
                          _time.isEmpty ||
                          _location.isEmpty) {
                        showSnackBar(context, "Please fill out all fields!");
                      } else {
                        await CreateNews().whenComplete(() {
                          Navigator.pop(context);
                        });
                      }
                    }, 0, 0, 0, 0)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> CreateNews() async {
    Map data = {
      "title": _title,
      "description": _description,
      "location": _location,
      "time": _time,
      "image": _imageURL
    };
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(
        Uri.parse(
            "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/CreatePost.php"),
        body: body);
  }
}
