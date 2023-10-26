  import 'package:flutter/material.dart';

import '../Core/constants.dart';


Widget buildButton(
      String buttonText, IconData iconData, Function() onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.buttonblue,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 2,
      ),
      icon: Icon(iconData),
      label: Text(buttonText),
    );
  }
