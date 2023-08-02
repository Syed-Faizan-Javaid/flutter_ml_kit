import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class MachineLearningService {
  ImagePicker imagePicker = ImagePicker();

  Future<File> pickImage(ImageSource imageSource) async {
    final pickedImageFile = await imagePicker.pickImage(
      source: imageSource,
    );
    return File(pickedImageFile!.path);
  }

  Future<String> recogniseText(File? pickedFile) async {
    InputImage inputImage = InputImage.fromFile(pickedFile!);
    TextRecognizer textRecognizer = TextRecognizer();
    RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    return recognizedText.text;
  }

  Future<String?> scanImageForBarCode(File pickedImage) async {
    String? result;
    var barCodeScanner = GoogleMlKit.vision.barcodeScanner();
    final visionImage = InputImage.fromFile(pickedImage);
    var barcodeText = await barCodeScanner.processImage(visionImage);
    for (Barcode barcode in barcodeText) {
      result = barcode.displayValue!;
    }
    return result;
  }

  Future<List<String>> processImageForLabeling(File pickedImage) async {
    List<String> labelText = [];
    final ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);
    final inputImage = InputImage.fromFile(pickedImage);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      labelText.add(label.label);
    }
    return labelText;
  }

  Future<List<IdentifiedLanguage>> identifyLanguage(String text) async {
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final String response = await languageIdentifier.identifyLanguage(text);
    final List<IdentifiedLanguage> possibleLanguages = await languageIdentifier.identifyPossibleLanguages(text);
    return possibleLanguages;
  }
}
