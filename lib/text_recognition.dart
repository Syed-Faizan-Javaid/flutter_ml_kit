import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/machine_learning_services.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognition extends StatefulWidget {
  const TextRecognition({super.key});

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  File? _pickedImage;

  String _result = "";

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff2D46C4),
        centerTitle: true,
        title: Text(
          "Text Recognition".toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (_pickedImage != null)
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.file(
                    _pickedImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              if (_pickedImage == null)
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Upload Image",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
              if (_pickedImage != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                        onPressed: () {
                          setState(() {
                            _pickedImage = null;
                            _result = "";
                          });
                        },
                        child: Text(
                          "Clear Image".toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                        onPressed: () async {
                          MachineLearningService machineLearningService = MachineLearningService();
                          String result = await machineLearningService.recogniseText(_pickedImage);

                          setState(() {
                            _result = result;
                          });
                        },
                        child: Text(
                          "Process Image".toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              if (_result.isNotEmpty)
                Text(
                  "Result".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              if (_result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: Colors.grey.shade300,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      _result,
                      style: TextStyle(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage(ImageSource imageSource) async {
    final pickedImageFile = await imagePicker.pickImage(
      source: imageSource,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
  }
}
