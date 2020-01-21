import 'package:flutter/material.dart';
import 'package:vertex_ui/localizations.dart';

import 'settings_model.dart';

/// Controller ? -- MVC Pattern
class SettingsCard extends StatefulWidget {
  final Settings settings;

  SettingsCard(this.settings);

  @override
  _SettingsCardState createState() => _SettingsCardState(settings);
}

class _SettingsCardState extends State<SettingsCard> {
  Settings settings;

  _SettingsCardState(this.settings);

  String _audioInput = 'None Selected';
  String _audioOutput = 'None Selected';
  double _audioInputSensitivity = 50.0;
  String _videoInput = 'None Selected';
  bool _audioInputIsMute = false;
  bool _audioOutputIsMute = false;
  List<bool> _audioInputIsSelected = [true, false];
  List<bool> _audioOutputIsSelected = [true, false];

//  List<bool> _audioOutputIsMute = [true, false];

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
                        widget.settings.audioInput = _audioInput;
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
                        widget.settings.audioOutput = _audioOutput;
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
                      widget.settings.audioInputSensitivity =
                          _audioInputSensitivity.toDouble();
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
                        widget.settings.videoInput = _videoInput;
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
    // TODO: Save to file here ?
    // Update the state of the values
    setState(() {
      widget.settings.audioInput = _audioInput;
      widget.settings.audioOutput = _audioOutput;
      widget.settings.audioInputSensitivity = _audioInputSensitivity.toDouble();
      widget.settings.videoInput = _videoInput;
      widget.settings.audioInputIsMute = _audioInputIsMute;
      widget.settings.audioOutputIsMute = _audioOutputIsMute;
//      Settings settings = new Settings(_audioInput, _audioOutput, _audioInputSensitivity, _videoInput, _audioInputIsMute, _audioOutputIsMute);
    });

    // Print values to console
    print('audioInput: ' + widget.settings.audioInput);
    print('audioOutput: ' + widget.settings.audioInput);
    print('audioInputSensitivity: ' +
        widget.settings.audioInputSensitivity.toString());
    print('videoInput: ' + widget.settings.videoInput);
    print('audioInputIsMute: ' + widget.settings.audioInputIsMute.toString());
    print('audioOutputIsMute: ' + widget.settings.audioOutputIsMute.toString());
  }

  /// Language Text
  ///
  ///TODO: Move to main page ?
//  Widget get displayLanguageText {
//    Locale myLocale = Localizations.localeOf(context);
//    return Container(
//      child: Card(
//          color: Colors.lightGreen[800],
//          child: Padding(
//            padding: const EdgeInsets.only(
//              top: 10.0,
//              bottom: 8.0,
//              left: 20.0,
//            ),
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text("Language: " + myLocale.toString(),
//                    style: Theme.of(context).textTheme.headline),
//              ],
//            ),
//          )),
//    );
//  }

//  /// Output Device Drop box
//  Widget get displayLanguageDropBox {
//    Locale myLocale = Localizations.localeOf(context);
//    return Column(
//      children: <Widget>[
//        Container(
//            padding: EdgeInsets.symmetric(
//              vertical: 16.0,
//              horizontal: 16.0,
//            ),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                new FlatButton(
//                  child: new Text("English"),
//                  color: AppLocalizations.of(context).locale == "en"
//                      ? Colors.lightGreen
//                      : Colors.white12,
//                  onPressed: () {
//                    this.setState(() {
//                      widget.callback(new Locale("en"));
//                    });
//                  },
//                ),
//                new FlatButton(
//                  child: new Text("عربى"),
//                  color: AppLocalizations.of(context).locale == "ar"
//                      ? Colors.lightGreen
//                      : Colors.white12,
//                  onPressed: () {
//                    widget.callback(new Locale("ar"));
//                  },
//                ),
//              ],
//            )),
//      ],
//    );
//  }

  /// -- Build Widget --
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
//      color: Colors.black87, // TODO: Comment me out when all is built
      height: 1000.0,
      child: ListView(
        children: <Widget>[
          audioInputText,
          audioInputDropBox,
          audioOutputText,
          audioOutputDropBox,
          audioInputSensitivityText,
          audioInputSensitivitySlider,
          videoInputText,
          videoInputDropBox,
          audioInputIsMuteText,
          audioInputIsMuteToggle,
          audioOutputIsMuteText,
          audioOutputIsMuteToggle,
          updateSettingsButton,
        ],
      ),
    );
  }
}
