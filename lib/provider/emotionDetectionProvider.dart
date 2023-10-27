import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:tflite_v2/tflite_v2.dart';

import '../Core/constants.dart';

class EmotionDetectionProvider with ChangeNotifier {
 
  bool? _isLoading = true;
  List<dynamic> _predictions = [];
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  bool? get isLoading => _isLoading;
  List<dynamic> get predictions => _predictions;
  XFile? get pickedFile => _pickedFile;
  CroppedFile? get croppedFile => _croppedFile;

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/ai/model_unquant.tflite',
        labels: 'assets/ai/labels.txt');
    notifyListeners();
  }

  picking_image(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    _pickedFile = await picker.pickImage(
      source: source,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (_pickedFile != null) {
      _croppedFile = await CropFunction.cropImage(_pickedFile!.path);
      if (_croppedFile == null) {
 
        detect_image(File(_pickedFile!.path));
      } else {
        detect_image(File(_croppedFile!.path));
      }
    } else {
      // Handle case where image picking was canceled
      _isLoading = false;
      notifyListeners();
    }
  }

  detect_image(File image) async {
    var predictions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    _isLoading = false;
    _predictions = predictions!;
    notifyListeners();
  }
}
