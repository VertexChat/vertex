import 'package:flutter/material.dart';
import 'settings_model.dart';
import 'settings_card.dart';

/// Want this page to be able to display and modify all settings
/// Could sub page later on ?
///
/// View -- MVC Pattern
class SettingsPage extends StatefulWidget {
  final String title;

  SettingsPage(this.title);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Settings> initialSettings = []
  ..add(Settings('Microphone', 'Speakers', 10))
  ..add(Settings('Microphone', 'Headphones', 5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SettingsCard(initialSettings[1]),
        ));
  }
}

/// Method for settings choices
//void choiceAction(String choice) {
//  if (choice == Constants.settings) {
//    print("Settings");
//  } else if (choice == Constants.subscribe) {
//    print("Subscribe");
//  } else if (choice == Constants.signOut) {
//    print("SignOut");
//  }
//}
