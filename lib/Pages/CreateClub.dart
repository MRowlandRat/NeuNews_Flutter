import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreateClubPage extends StatefulWidget {
  const CreateClubPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateClubPage();
}

class _CreateClubPage extends State<CreateClubPage> {
  final ImagePicker picker = ImagePicker();
  String _name = "";
  String _description = "";
  var fileToUpload = null;

  // clubImage will be an image upload later once S3 bucket is set up, for now it's just a URL

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  dispose() {
    nameController.text = '';
    descController.text = '';
    fileToUpload = null;
    super.dispose();
  }

  Future<void> _getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileToUpload = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neuBar('Create Club'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: inputField("Club name", Icons.edit, nameController)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Club description", Icons.description, descController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Container(
                        width:200,
                        child: (fileToUpload != null)
                            ? Card(
                          elevation: 10,
                          shadowColor: Colors.amber,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Image border
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(80), // Image radius
                                  child: Image.file(fileToUpload),
                                ),
                              ),
                              ElevatedButton.icon(onPressed: _getImage, label: const Text('Change image'))
                            ],
                          ),
                        )
                            : OutlinedButton.icon(
                          onPressed: _getImage,
                          label: const Text(
                              'No image selected, please select from gallery'),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create Club", () async {
                      _name = nameController.text;
                      _description = descController.text;
                      if (_name.isEmpty || _description.isEmpty || fileToUpload == null) {
                        showSnackBar(context, "Please fill out all fields!");
                      } else {
                        await CreateClub().whenComplete(() {
                          Navigator.pop(context);
                        });
                      }
                    }, 0, 0, 0, 0)),
              ],
            ),
          ],
        ),
      )
    );
  }

  Future<String> _uploadImage() async {
    Uri uri = Uri.parse(
        'http://neunewsapi.us-east-1.elasticbeanstalk.com/UploadImage.php');
    var request = new http.MultipartRequest("POST", uri);
    var file = await http.MultipartFile.fromPath("file", fileToUpload.path);
    request.files.add(file);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return jsonDecode(response.body).toString();
  }

  Future<void> CreateClub() async {
    String url = await _uploadImage();
    Map data = {"name": _name, "description": _description, "image": url};
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(
        Uri.parse(
            "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Clubs/CreateClub.php"),
        body: body);
  }
}
