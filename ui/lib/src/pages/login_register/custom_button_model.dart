import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonModel {
  String buttonDisplayName;
  MaterialPageRoute pageToOpen;
  Color buttonColor;

  ButtonModel(this.buttonDisplayName, this.pageToOpen, this.buttonColor);
} //End model class
