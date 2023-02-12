import 'package:flutter/material.dart';

import 'colors.dart';

const String apiKey = '33509245-5747b4d1ce65ce9e54d4b3fba';
var snackBar = const SnackBar(
    backgroundColor: ColorConstant.primaryColor,
    duration: Duration(milliseconds: 50),
    content: Text(
      'Added to Favorite',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ));
var alreadySnackBar = const SnackBar(
    backgroundColor: ColorConstant.primaryColor,
    duration: Duration(milliseconds: 50),
    content: Text(
      'Already added to Favorite',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ));
