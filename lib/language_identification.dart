import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/machine_learning_services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'constants/language_locale.dart';

class LanguageIdentification extends StatefulWidget {
  const LanguageIdentification({super.key});

  @override
  State<LanguageIdentification> createState() => _LanguageIdentificationState();
}

class _LanguageIdentificationState extends State<LanguageIdentification> {
  final TextEditingController _textEditingController = TextEditingController();
  List<IdentifiedLanguage> possibleLanguages = [];
  String emptyResult = "";
  var language = LanguageLocal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff2D46C4),
        centerTitle: true,
        title: Text(
          "Language Identification".toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter Text to Identify",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      enabledBorder:
                          OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff2D46C4)), borderRadius: BorderRadius.circular(15.0)),
                      hintText: "Enter Text"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                        onPressed: () async {
                          MachineLearningService machineLearningService = MachineLearningService();
                          List<IdentifiedLanguage> result = await machineLearningService.identifyLanguage(_textEditingController.text);

                          setState(() {
                            if (result.isEmpty) {
                              emptyResult = "No Data Found";
                            } else {
                              possibleLanguages.addAll(result);
                            }
                          });
                        },
                        child: Text(
                          "Process Text".toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2D46C4)),
                        onPressed: () async {
                          MachineLearningService machineLearningService = MachineLearningService();
                          List<IdentifiedLanguage> result = await machineLearningService.identifyLanguage(_textEditingController.text);

                          setState(() {
                            possibleLanguages.clear();
                            emptyResult = "";
                            _textEditingController.clear();
                          });
                        },
                        child: Text(
                          "Clear Result".toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (possibleLanguages.isNotEmpty)
                  Text(
                    "Possible Languages".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                if (possibleLanguages.isNotEmpty)
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
                            itemCount: possibleLanguages.length,
                            itemBuilder: (context, index) {
                              return Text(language.getDisplayLanguage(possibleLanguages[index].languageTag)["name"]);
                            })),
                  ),
                Text(
                  emptyResult.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
