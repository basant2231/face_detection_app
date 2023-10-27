import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:tflite_v2/tflite_v2.dart';

import '../Core/constants.dart';
import '../widgets/dialog.dart';

class EmotionDetectionProvider with ChangeNotifier {
  bool? _isLoading = true;
  List<dynamic> _predictions = [];
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  bool? get isLoading => _isLoading;
  List<dynamic> get predictions => _predictions;
  XFile? get pickedFile => _pickedFile;
  CroppedFile? get croppedFile => _croppedFile;

  Future<void> loadmodel(context) async {
    try {
      await Tflite.loadModel(
        model: 'assets/ai/model_unquant.tflite',
        labels: 'assets/ai/labels.txt',
      );
    } catch (e) {
      showErrorDialog(context, e);
    }
    notifyListeners();
  }

Future<void> picking_image(ImageSource source, context) async {
  final ImagePicker picker = ImagePicker();
  try {
    _pickedFile = await picker.pickImage(
      source: source,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (_pickedFile != null && _pickedFile!.path.isNotEmpty) {
      _croppedFile = await CropFunction.cropImage(_pickedFile?.path ?? '');

      if (_croppedFile != null && _croppedFile!.path.isNotEmpty) {
        detect_image(File(_croppedFile?.path??""), context);
      } else {
        detect_image(File(_pickedFile?.path??""), context);
      }
    } else {
      // Handle case where image picking was canceled or file paths are empty
      _isLoading = false;
      notifyListeners();
    }
  } catch (e) {
    print("Error: $e"); // Print the error for debugging purposes
    showErrorDialog(context, e);
    _isLoading = false;
    notifyListeners();
  }
}


  Future<void> detect_image(File image, context) async {
    try {
      var predictions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      _isLoading = false;
      _predictions = predictions!;
    } catch (e) {
      showErrorDialog(context, e);
    }
    notifyListeners();
  }
}
