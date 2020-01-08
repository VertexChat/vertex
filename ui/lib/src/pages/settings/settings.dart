import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AudioManager {
  var inputDevice = ["USB Headset", "3.5mm Headset"];
  var outputDevice = ["USB Speaker", "USB Headset"];
  var minSensitivity = 0;
  var maxSensitivity = 100;
  var inputSensitivity;
}

class InterfaceManager {
  var language = ["English", "German", "French"];
  var theme = ["Light", "Dark"];
}

/// Settings page - Probably need to add a stateless widget ?
class SettingsRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AudioManager audioManager = new AudioManager();
    InterfaceManager interfaceManager = new InterfaceManager();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),

      body: ListView.builder(
        itemBuilder: (context, index){

          return Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey[500]),
              color: Colors.white,
            ),
            child: new Column(
              children: <Widget>[
                getAudioWidget(context),
              ],
            ),
          );
        },
      ),
    );
  }
  /// Widget for handling the audio tab
  Widget getAudioWidget(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(height: 100.0, width: 10.0, color: Colors.blue),
        new Container(height: 100.0, width: 10.0, color: Colors.red),
        new Container(
          child: new Text("Audio", textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Bold',
              fontSize: 18.0,
              color: Colors.black),
          ),
          decoration: new BoxDecoration(
            color: Colors.amber,
          ),
          height: 100.0,
        ),
        Spacer(),
      ],
    );
  }
}



/// Method for settings choices
void choiceAction(String choice) {
  if (choice == Constants.settings) {
    print("Settings");
  } else if (choice == Constants.subscribe) {
    print("Subscribe");
  } else if (choice == Constants.signOut) {
    print("SignOut");
  }
}
