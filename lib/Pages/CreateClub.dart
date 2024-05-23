import 'package:flutter/material.dart';
import '../ReusableWidgets/NeuAppBar.dart';
import '../ReusableWidgets/Button.dart';
import '../ReusableWidgets/InputField.dart';

class CreateClubPage extends StatefulWidget {
  const CreateClubPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateClubPage();
}

class _CreateClubPage extends State<CreateClubPage> {
  String clubName = "";
  String clubDescription = "";
  // clubImage will be an image upload later once S3 bucket is set up, for now it's just a URL
  String clubImage = "";

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
                // button(context, "Back", () {
                //   Navigator.pop(context);
                // }, 0, 0, 0, 0),
                Padding(
                    padding: const EdgeInsets.fromLTRB(180, 16, 24, 0),
                    child: button(context, "Create News", () {
                      clubName = nameController.text;
                      clubDescription = descController.text;
                      clubImage = imageController.text;
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
