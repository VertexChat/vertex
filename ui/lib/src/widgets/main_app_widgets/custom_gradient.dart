import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

LinearGradient getCustomGradient() {
  return LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.lightGreen[900],
      Colors.lightGreen[800],
      Colors.lightGreen[700],
      Colors.lightGreen[500],
      Colors.lightGreen[300],
    ],
  );
} //End LinearGradient
