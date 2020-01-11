import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class AudioManager {
  String inputDevice;
  String outputDevice;
  final minSensitivity = 0;
  final maxSensitivity = 100;
  var inputSensitivity;

  // ignore: non_constant_identifier_names
  get input_device {
    return inputDevice;
  }

  // ignore: non_constant_identifier_names
  set input_device(String inputDevice) {
    this.inputDevice = inputDevice;
  }

  // ignore: non_constant_identifier_names
  get output_device {
    return outputDevice;
  }

  // ignore: non_constant_identifier_names
  set output_device(String outputDevice) {
    this.outputDevice = outputDevice;
  }

  // ignore: non_constant_identifier_names
  get input_sensitivity {
    return inputSensitivity;
  }

  // ignore: non_constant_identifier_names
  set input_sensitivity(var inputSensitivity) {
    if (inputSensitivity <= maxSensitivity &&
        inputSensitivity >= minSensitivity) {
      this.inputSensitivity = inputSensitivity;
    }
  }
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
        itemBuilder: (context, index) {
          return Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey[500]),
              color: Colors.white,
            ),
            child: new Column(
              children: <Widget>[
                getAudioTitle(context),
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
        new Row(
          children: <Widget>[
            new Container(
              height: 100.0,
              width: 100.0,
              color: Colors.blue,
              child: Text("Row 0 Container 0"),
            ),
            new Container(
              height: 100.0,
              width: 100.0,
              color: Colors.blue,
              child: Text("Row 0 Container 1"),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }

  /// @param BuildContext -- reference to location of Widget within tree of all Widgets
  Widget getAudioTitle(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          child: new Text(
            "Audio Settings",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Bold', fontSize: 18.0, color: Colors.black),
          ),
          decoration: new BoxDecoration(
            color: Colors.greenAccent,
          ),
          height: 100.0,
        ),
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
