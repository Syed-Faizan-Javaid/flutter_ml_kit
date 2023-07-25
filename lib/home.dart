import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pickedImage;
  String string = "TextRecognition";
  String result = "";

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            drawerItem("Text recognition", Icons.title, "TextRecognition"),
            drawerItem("Image labeling", Icons.terrain, "ImageLabeling"),
            drawerItem("Barcode scanning", Icons.workspaces_outline, "BarcodeScanning"),
            TextButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          "Complete your action using..",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancel",
                            ),
                          ),
                        ],
                        content: Container(
                          height: 120,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text(
                                  "Camera",
                                ),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text(
                                  "Gallery",
                                ),
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add),
              label: const Text(
                'Add Image',
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (string == "TextRecognition") recogniseText();
              },
              icon: Icon(Icons.add),
              label: const Text(
                'Process',
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(result),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _pickImage(ImageSource imageSource) async {
    final pickedImageFile = await picker.pickImage(
      source: imageSource,
    );
    _pickedImage = File(pickedImageFile!.path);
  }

  Widget drawerItem(String title, IconData iconData, String _string) {
    return InkWell(
      onTap: () {
        setState(() {
          string = _string;
        });
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          ListTile(
            leading: Icon(iconData),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  recogniseText() async {
    InputImage inputImage = InputImage.fromFile(_pickedImage!);
    TextRecognizer textRecognizer = TextRecognizer();
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    setState(() {
      result = recognizedText.text;
    });
  }
}
