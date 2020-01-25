import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:vertex_ui/src/pages/settings/settings_card.dart';
import 'package:vertex_ui/src/widgets/text_widget.dart';
import '../../../localizations.dart';
import 'settings_model.dart';

/// Want this page to be able to display and modify all settings
/// Could sub page later on ?
///
/// View -- MVC Pattern
class SettingsPage extends StatefulWidget {
  final Settings settings;
  SettingsPage(this.settings);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState();

  // Initial values for fields
  String _audioInput = 'None Selected';
  String _audioOutput = 'None Selected';
  double _audioInputSensitivity = 50.0;
  String _videoInput = 'None Selected';
  bool _audioInputIsMute = false;
  bool _audioOutputIsMute = false;

  // True / False list for toggle buttons
  List<bool> _audioInputIsSelected = [true, false];
  List<bool> _audioOutputIsSelected = [true, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// -- Audio Input--
  /// Text Display
  Widget get audioInputText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Audio In: " + _audioInput,
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- Audio Input --
  /// DropBox Display
  ///
  /// TODO: Manipulate for systems hardware
  Widget get audioInputDropBox {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _audioInput,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.lightGreen[800]),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String newOutputDeviceValue) {
                      setState(() {
                        _audioInput = newOutputDeviceValue;
                      });
                    },
                    // TODO: Look at getting audio options here
                    items: <String>[
                      'None Selected',
                      'Integrated Microphone',
                      'External Microphone'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  /// -- Audio Output --
  /// Text Display
  Widget get audioOutputText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Audio Out: " + _audioOutput,
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- Audio Output --
  /// DropBox Display
  Widget get audioOutputDropBox {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _audioOutput,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.lightGreen[800]),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String newOutputDeviceValue) {
                      setState(() {
                        _audioOutput = newOutputDeviceValue;
                      });
                    },
                    // TODO: Look at getting audio options here
                    items: <String>['None Selected', 'Speakers', 'Headphones']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  /// -- Audio Input Sensitivity --
  /// Text Display
  Widget get audioInputSensitivityText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "Audio Input Sensitivity: " +
                        _audioInputSensitivity.floor().toString(),
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- Audio Input Sensitivity --
  /// Slider Display
  Widget get audioInputSensitivitySlider {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Slider(
                    activeColor: Colors.lightGreen,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (newInputSensitivity) {
                      setState(
                          () => _audioInputSensitivity = newInputSensitivity);
                    },
                    value: _audioInputSensitivity,
                  ),
                ),

                // This displays the slider value
                Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_audioInputSensitivity.toInt()}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            )),
      ],
    );
  }

  /// -- WebCam Input --
  /// Text Widget
  Widget get videoInputText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Webcam In: " + _videoInput,
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- WebCam Input --
  /// DropBox Widget
  Widget get videoInputDropBox {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _videoInput,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.lightGreen[800]),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String newVideoDeviceValue) {
                      setState(() {
                        _videoInput = newVideoDeviceValue;
                      });
                    },
                    items: <String>[
                      'None Selected',
                      'Webcam',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  /// -- Mute Microphone --
  /// Text Widget
  Widget get audioInputIsMuteText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Mute Audio Input: " + _audioInputIsMute.toString(),
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- Mute Microphone --
  /// ToggleButton Widget
  Widget get audioInputIsMuteToggle {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.do_not_disturb_alt),
                    Icon(Icons.check),
                  ],
//                  // Need mutually exclusive check
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _audioInputIsSelected.length; i++) {
                        if (i == index) {
                          _audioInputIsSelected[i] = true;
                        } else {
                          _audioInputIsSelected[i] = false;
                        }
                        _audioInputIsMute = _audioInputIsSelected[i];
                      }
                    });
                  },
                  isSelected: _audioInputIsSelected,
                ),
              ],
            )),
      ],
    );
  }

  /// -- Mute Headphone --
  /// Text Widget
  Widget get audioOutputIsMuteText {
    return Container(
      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 8.0,
              left: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Mute Audio Output: " + _audioOutputIsMute.toString(),
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// -- Mute Headphone --
  /// ToggleButton Widget
  Widget get audioOutputIsMuteToggle {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ToggleButtons(
                  children: <Widget>[
                    Icon(Icons.do_not_disturb_alt),
                    Icon(Icons.check),
                  ],
//                  // Need mutually exclusive check
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _audioOutputIsSelected.length; i++) {
                        if (i == index) {
                          _audioOutputIsSelected[i] = true;
                        } else {
                          _audioOutputIsSelected[i] = false;
                        }
                        _audioOutputIsMute = _audioOutputIsSelected[i];
                      }
                    });
                  },
                  isSelected: _audioOutputIsSelected,
                ),
              ],
            )),
      ],
    );
  }

  /// -- Update Settings --
  /// Button Display
  Widget get updateSettingsButton {
    return RaisedButton(
      onPressed: () => updateSettings(),
      child: Text('Save Settings'),
      color: Colors.lightGreen[700],
    );
  }

  /// -- Update Settings --
  /// Button Functionality
  void updateSettings() {
//    Settings settings;
    setState(() {
//      settings = new Settings(_audioInput, _audioOutput, _audioInputSensitivity,
//          _videoInput, _audioInputIsMute, _audioOutputIsMute);
      widget.settings.audioInput = _audioInput;
    });

    // Print values to console
    print('audioInput: ' + widget.settings.audioInput);
//    print('audioOutput: ' + settings.audioInput);
//    print(
//        'audioInputSensitivity: ' + settings.audioInputSensitivity.toString());
//    print('videoInput: ' + settings.videoInput);
//    print('audioInputIsMute: ' + settings.audioInputIsMute.toString());
//    print('audioOutputIsMute: ' + settings.audioOutputIsMute.toString());

//    return widget.storage.writeSettings(
//        settings.audioInput,
//        settings.audioOutput,
//        settings.audioInputSensitivity,
//        settings.videoInput,
//        settings.audioInputIsMute,
//        settings.audioOutputIsMute);
  }

//  Widget settingsCard(BuildContext context) {
//    return Container(
////      color: Colors.black87, // TODO: Comment me out when all is built
//      height: 1000.0,
//      child: ListView(
//        children: <Widget>[
//          audioInputText,
//          audioInputDropBox,
//          audioOutputText,
//          audioOutputDropBox,
//          audioInputSensitivityText,
//          audioInputSensitivitySlider,
//          videoInputText,
//          videoInputDropBox,
//          audioInputIsMuteText,
//          audioInputIsMuteToggle,
//          audioOutputIsMuteText,
//          audioOutputIsMuteToggle,
//          updateSettingsButton,
//        ],
//      ),
//    );
//  }

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
          ],
        ),
      ),
    );
  }
}

//class SaveToFile {
//  /// -- Data Persistence --
//  // Step 1 - Find correct local path
//  // Adapted from: https://flutter.dev/docs/cookbook/persistence/reading-writing-files
//  Future<String> get _localPath async {
//    // Storing on platforms Documents Directory
//    final directory = await getApplicationDocumentsDirectory();
//
//    print('Directory located: ' + directory.toString());
//    return directory.path;
//  }
//
//  /// -- Data Persistence --
//  // Step 2 - Create reference to file location
//  // TODO: Rename to settings
//  Future<File> get _localFile async {
//    final path = await _localPath;
//    return File('$path/settings.txt');
//  }
//
//  /// -- Data Persistence --
//  // Step 3 - Write data to file
//  Future<File> writeSettings(
//      String aI, String aO, double aIS, String vI, bool aIIM, aOIM) async {
//    final file = await _localFile;
//
//    // Write to file
//    return file.writeAsString('$aIS');
//  }
//}
