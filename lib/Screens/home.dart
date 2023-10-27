import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:face_detection_app/Core/constants.dart';
import 'package:face_detection_app/provider/emotionDetectionProvider.dart';
import 'package:face_detection_app/widgets/button.dart';
import 'package:face_detection_app/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tflite_v2/tflite_v2.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Constants.mainlighterblue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constants.mainblue,
          title: const Text("Emotion Face Detection App"),
          centerTitle: true,
        ),
        body: Consumer<EmotionDetectionProvider>(
          builder: (context, provider, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Constants.mainblue,
              ),
              height: h,
              width: w,
              margin: const EdgeInsets.all(7),
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    width: 280,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 50,
                          child: Container(
                            height: 200,
                            width: 200,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: provider.isLoading == false
                                  ? Container(
                                      child: provider.croppedFile == null
                                          ? Image.file(
                                              File(provider.pickedFile!.path))
                                          : provider.croppedFile != null
                                              ? Image.file(File(
                                                  provider.pickedFile!.path))
                                              : Container(),
                                    )
                                  : Image.asset(
                                      Constants.girlFace,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildButton(
                    "Choose from Camera",
                    Icons.camera_alt,
                    () {
                      showcropDialog(context);
                      Future.delayed(Duration(seconds: 3), () {
                        provider.picking_image(ImageSource.camera);
                      });
                    },
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  buildButton(
                    "Choose from Gallery",
                    Icons
                        .photo_library, // Use Icons.photo_library for the gallery icon
                    () {
                      showcropDialog(
                        context,
                      );
                      Future.delayed(Duration(seconds: 3), () {
                        provider.picking_image(ImageSource.camera);
                      });
                    },
                  ),
                  provider.isLoading == false
                      ? Text(
                          '${provider.predictions[0]['label']}'
                              .substring(2)
                              .toUpperCase(),
                          style: const TextStyle(
                            color: Constants.mainlighterblue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  provider.isLoading == false
                      ? const Text(
                          'confidence :',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  provider.isLoading == false
                      ? Text(
                          '${((provider.predictions[0]['confidence'] * 100).toStringAsFixed(2))}%',
                          style: GoogleFonts.orbitron(
                            textStyle: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            );
          },
        ));
  }
}
