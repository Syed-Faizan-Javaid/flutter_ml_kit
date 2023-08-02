import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/barcode_scanning.dart';
import 'package:flutter_ml_kit/image_labeling.dart';
import 'package:flutter_ml_kit/language_identification.dart';
import 'package:flutter_ml_kit/text_recognition.dart';
import 'package:flutter_ml_kit/ui_components/function_card.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FunctionModel> mlFunctions = [
    FunctionModel(functionName: "TEXT RECOGNITION", functionIcon: const Icon(Icons.text_fields_outlined)),
    FunctionModel(functionName: "BARCODE SCANNING", functionIcon: const Icon(Icons.scanner_outlined)),
    FunctionModel(functionName: "IMAGE LABELING", functionIcon: const Icon(Icons.image_search_outlined)),
    FunctionModel(functionName: "LANGUAGE IDENTIFICATION", functionIcon: const Icon(Icons.language_outlined)),
  ];

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .40,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff5C7FFC),
                        Color(0xff2D46C4),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Machine Learning with Flutter".toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Icon(
                          Icons.lightbulb_circle_outlined,
                          size: 150,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10),
                            itemCount: mlFunctions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    if (mlFunctions[index].functionName == "TEXT RECOGNITION") {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TextRecognition()));
                                    } else if (mlFunctions[index].functionName == "BARCODE SCANNING") {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BarcodeScanning()));
                                    } else if (mlFunctions[index].functionName == "IMAGE LABELING") {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ImageLabeling()));
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageIdentification()));
                                    }
                                  },
                                  child: FunctionCard(mlFunctions: mlFunctions[index]));
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FunctionModel {
  String functionName;
  Icon functionIcon;
  FunctionModel({required this.functionName, required this.functionIcon});
}
