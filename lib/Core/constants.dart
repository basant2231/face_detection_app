  

  import 'package:face_detection_app/Screens/home.dart';
import 'package:face_detection_app/Screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class Constants{
  static  const Color mainblue = Color(0xFF1A3346);
    static const Color mainlighterblue = Color(0xFF177EA7);
  static const Color buttonblue = Color(0xFF3A5F78);
  
  static  const String girlFace='assets/images/girlFace.jpg';
  }

class CropFunction {
  static Future<CroppedFile?> cropImage(String filePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      return croppedFile;
    } catch (e) {
      return null;
    }
  }
}