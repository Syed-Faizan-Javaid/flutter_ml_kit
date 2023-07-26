import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';

class MachineLearningService {
  Future<String> recogniseText(File? pickedFile) async {
    InputImage inputImage = InputImage.fromFile(pickedFile!);
    TextRecognizer textRecognizer = TextRecognizer();
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    return recognizedText.text;
  }
}
