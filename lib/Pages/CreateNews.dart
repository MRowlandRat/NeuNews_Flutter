import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neunews_flutter/ReusableWidgets/SnackBarMessage.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CreateNewsPage extends StatefulWidget {
  const CreateNewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateNewsPage();
}

class _CreateNewsPage extends State<CreateNewsPage> {
  String _title = "";
  String _description = "";
  String _location = "";
  String _time = "";
  final ImagePicker picker = ImagePicker();
  var fileToUpload = null;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  dispose() {
    nameController.text = '';
    descController.text = '';
    locationController.text = '';
    timeController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neuBar('Create News'),
      body: SingleChildScrollView(
        child: Align(
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
                child: inputField("Location", Icons.map, locationController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: inputField("Time", Icons.watch_later, timeController),
              ),
              const SizedBox(height: 20.0),
              Container(
                  width: 200,
                  child: (fileToUpload != null)
                      ? Card(
                    elevation: 10,
                    shadowColor: Colors.amber,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(20), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(80), // Image radius
                            child: Image.file(fileToUpload),
                          ),
                        ),
                        ElevatedButton.icon(
                            onPressed: _getImage,
                            label: const Text('Change image'))
                      ],
                    ),
                  )
                      : OutlinedButton.icon(
                    onPressed: _getImage,
                    label: const Text(
                        'No image selected, please select from gallery'),
                  )),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                      child: button(context, "Create News", () async {
                        _title = nameController.text;
                        _description = descController.text;
                        _time = timeController.text;
                        _location = locationController.text;
                        if (_title.isEmpty ||
                            _description.isEmpty ||
                            fileToUpload == null ||
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

  Future<void> _getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileToUpload = File(image!.path);
    });
  }

  Future<void> CreateNews() async {
    Map data = {
      "title": _title,
      "description": _description,
      "location": _location,
      "time": _time,
      "image": await _uploadImage()
    };
    //encode Map to JSON
    var body = json.encode(data);
    http.Response res = await http.post(
        Uri.parse(
            "http://neunewsapi.us-east-1.elasticbeanstalk.com/api/Posts/CreatePost.php"),
        body: body);
    print(jsonDecode(res.body).toString());
  }
}
