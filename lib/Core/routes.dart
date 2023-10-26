
  import 'package:flutter/material.dart';

import '../Screens/home.dart';
import '../Screens/splashScreen.dart';

class Routes {
     static const String splashScreen = '/splashScreen';
     static const String homeScreen = '/homeScreen';

      static Map<String, WidgetBuilder> get routes {
    return {
     splashScreen: (context) =>  const SplashScreen(),
     homeScreen: (context) =>  const Home(),
     
    };
  }
  }