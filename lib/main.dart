import 'package:face_detection_app/Core/constants.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Core/routes.dart';

import 'provider/emotionDetectionProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => EmotionDetectionProvider()..loadmodel(context),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Constants.mainblue,
            fontFamily: 'poppins',
          ),
          initialRoute:Routes.homeScreen,
                routes: Routes.routes,
          ),
    );
  }
}
