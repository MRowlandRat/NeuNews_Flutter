import 'package:flutter/material.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';

class CreateNewsPage extends StatefulWidget {
  const CreateNewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateNewsPage();
}

class _CreateNewsPage extends State<CreateNewsPage> {
  String newsTitle = "";
  String newsDescription = "";
  // newsImage will be an image upload later once S3 bucket is set up, for now it's just a URL
  String newsImage = "";

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
        appBar: neuBar('Create News'),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: inputField(
                          "Title", Icons.title, nameController)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Description", Icons.description, descController),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: inputField(
                        "Image URL", Icons.image, imageController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                // button(context, "Back", () {
                //   Navigator.pop(context);
                // }, 0, 0, 0, 0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                  child: button(context, "Create News", () {
                    newsTitle = nameController.text;
                    newsDescription = descController.text;
                    newsImage = imageController.text;
                    //create object

                    //upload object to DB

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
