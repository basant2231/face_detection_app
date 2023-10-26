import 'dart:async';


import 'package:flutter/material.dart';

import '../Core/constants.dart';
import '../Core/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  Timer? timer;
  bool imageLoaded = false; // Track whether the image is loaded

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 3000), _goNext);
    _loadImage(); // Load the image when the widget initializes
  }

  void _loadImage() async {
    // Simulate loading the image with a delay (replace with actual loading logic)
    await Future.delayed(const Duration(milliseconds: 1));

    // Mark the image as loaded
    setState(() {
      imageLoaded = true;
    });
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, Routes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainblue,
      body: Center(
        child: Container(
          width: 420,
          height: 420,
          decoration: const BoxDecoration(
            // Use the background color as a placeholder
            color: Constants.mainblue,
          ),
          child: imageLoaded
              ? TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 1), // Animation duration
                  tween: Tween<double>(begin: 0, end: 1), // Opacity animation
                  builder: (BuildContext context, double value, Widget? child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 50,
                          child: Container(
                            height: 250,
                            width: 250,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                Constants.girlFace,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 350,
                            child: Text(
                              "Emotion Face Detection App",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            )),
                      ],
                    ),
                  ),
                )
              : const CircularProgressIndicator(), // Show a loading indicator
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
