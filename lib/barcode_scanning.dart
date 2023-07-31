import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/machine_learning_services.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScanning extends StatefulWidget {
  const BarcodeScanning({super.key});

  @override
  State<BarcodeScanning> createState() => _BarcodeScanningState();
}

class _BarcodeScanningState extends State<BarcodeScanning> {
  File? _pickedImage;

  String _result = "";

  final MachineLearningService _machineLearningService = MachineLearningService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff2D46C4),
          centerTitle: true,
          title: Text(
            "Barcode Scanner".toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
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
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_pickedImage == null)
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                    onPressed: () async {
                      File imageFile = await _machineLearningService.pickImage(ImageSource.gallery);
                      setState(() {
                        _pickedImage = imageFile;
                      });
                    },
                    child: Text(
                      "Pick Image".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    )),
              if (_pickedImage != null)
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                    onPressed: () async {
                      String? barCodeResult = await _machineLearningService.scanImageForBarCode(_pickedImage!);
                      setState(() {
                        _result = barCodeResult ?? "No Data Found";
                      });
                    },
                    child: Text(
                      "Scan".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                  onPressed: () {
                    setState(() {
                      _pickedImage = null;
                    });
                  },
                  child: Text(
                    "Clear".toUpperCase(),
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
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(child: Text(_result)),
            ),
          ),
        ]))));
  }
}
