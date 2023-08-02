import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/machine_learning_services.dart';
import 'package:image_picker/image_picker.dart';

class ImageLabeling extends StatefulWidget {
  const ImageLabeling({super.key});

  @override
  State<ImageLabeling> createState() => _ImageLabelingState();
}

class _ImageLabelingState extends State<ImageLabeling> {
  File? _pickedImage;

  List<String> _result = [];

  final MachineLearningService _machineLearningService = MachineLearningService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff2D46C4),
        centerTitle: true,
        title: Text(
          "Image Labeling".toUpperCase(),
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
                    onPressed: () async {
                      File imageFile = await _machineLearningService.pickImage(ImageSource.gallery);
                      setState(() {
                        _pickedImage = imageFile;
                      });
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
                            _result.clear();
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
                          List<String> result = await machineLearningService.processImageForLabeling(_pickedImage!);

                          setState(() {
                            if (result.isEmpty) {
                              _result.add("No Data Found");
                            } else {
                              _result.addAll(result);
                            }
                          });
                        },
                        child: Text(
                          "Process Image For Labeling".toUpperCase(),
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _result.length,
                          itemBuilder: (context, index) {
                            return Text("Label:$index ${_result[index]}");
                          })),
                )
            ],
          ),
        ),
      ),
    );
  }
}
