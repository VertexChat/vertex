import 'package:flutter/material.dart';

/// Model class for channels, this class is used for the UI inside the app drawer. It is
/// used to create channel UI elements

class ChannelModel {
  final String listName;
  final String title;
  final IconData iconData;

  ChannelModel({this.title, this.iconData, this.listName});
} //End class
