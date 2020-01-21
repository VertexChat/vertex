import 'package:flutter/material.dart';
import '../../../localizations.dart';
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
  // TODO: Add null check here: Check for file
  // If null --> Load blank list
  // Else --> Load file
  List<Settings> initialSettings = []..add(Settings(
      'None Selected', 'None Selected', 5, 'None Selected', true, false));

  Settings settings = new Settings(
      'None Selected', 'None Selected', 5, 'None Selected', true, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white12,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).title),
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            SettingsCard(settings),
          ],
        )));
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
