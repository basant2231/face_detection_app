import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../Core/constants.dart';

void showcropDialog(BuildContext context) {
  AwesomeDialog(
    btnCancelColor: Constants.mainblue,
    context: context,
    dialogType: DialogType.infoReverse,
    animType: AnimType.scale,
    title: 'info',
    descTextStyle: const TextStyle(
        fontWeight: FontWeight.bold, color: Constants.buttonblue, fontSize: 15),
    titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold, color: Constants.mainblue, fontSize: 20),
    desc: 'Crop the exact face for accurate answer',
    btnCancelOnPress: () {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    },
  ).show();
}
