import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vertex_ui/src/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// MAIN Settings view for mobile
class SettingsViewMobilePortrait extends StatefulWidget {
  SettingsViewMobilePortrait({Key key}) : super(key: key);

  @override
  _SettingsViewMobilePortrait createState() => _SettingsViewMobilePortrait();
}

class _SettingsViewMobilePortrait extends State<SettingsViewMobilePortrait> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _audioInput;
  String _audioOutput;
  double _audioInputSensitivity = 0.0;
  String _videoInput;
  bool _audioInputIsMute = false;
  bool _audioOutputIsMute = false;
  bool _theme; // Light --> true /  Dark --> false

  List<String> _defaultAudioInput = [
    'None Selected',
    'Integrated Microphone',
    'External Microphone'
  ];

  List<String> _defaultAudioOutput = [
    'None Selected',
    'Integrated Speakers',
    'External Headphones'
  ];

  List<String> _defaultVideoInput = [
    'None Selected',
    'Internal Webcam',
    'External Webcam'
  ];

  List<bool> _themeIsSelected = [true, false];

  /// -- Init State --
  @override
  void initState() {
    super.initState();
    restore();
  }

  /// -- Dispose --
  @override
  void dispose() {
    super.dispose();
  }

  // TODO: Nothing to do with brightness.. should be theme
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  // https://codingwithjoe.com/flutter-saving-and-restoring-with-sharedpreferences/
  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  // https://codingwithjoe.com/flutter-saving-and-restoring-with-sharedpreferences/
  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      _audioInput = (sharedPrefs.getString('audioInput') ?? 'None Selected');
      _audioOutput = (sharedPrefs.getString('audioOutput') ?? 'None Selected');
      _audioInputSensitivity =
          (sharedPrefs.getDouble('audioInputSensitivity') ?? 50.0);
      _videoInput = (sharedPrefs.getString('videoInput') ?? 'None Selected');
      _audioInputIsMute = (sharedPrefs.getBool('audioInputIsMute') ?? false);
      _audioOutputIsMute = (sharedPrefs.getBool('audioOutputIsMute') ?? false);
    });
  }

  /// -- Audio Input Card--
  /// Displays Text
  /// Displays Dropdown
  Widget get audioInCard {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget('Audio Input'),
              audioInputDropBox,
            ],
          ),
        ),
      ),
    );
  }

  /// -- Audio Input --
  /// DropBox Display
  /// TODO: Manipulate for systems hardware
  Widget get audioInputDropBox {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DropdownButton<String>(
              value: _audioInput,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white30,
              ),
              onChanged: (String value) {
                setState(() {
                  _audioInput = value;
                });
                // Save as key value pair
                save('audioInput', value);
              },
              items: _defaultAudioInput.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// -- Audio Card--
  /// Text Display
  Widget get audioOutCard {
    return Container(
      width: 600,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget("Audio Out"),
              audioOutputDropBox,
            ],
          ),
        ),
      ),
    );
  }

  /// -- Audio Output --
  /// DropBox Display
  Widget get audioOutputDropBox {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DropdownButton<String>(
              value: _audioOutput,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white30,
              ),
              onChanged: (String value) {
                setState(() {
                  _audioOutput = value;
                });
                save('audioOutput', value);
              },
              // TODO: Look at getting audio options here
              items: _defaultAudioOutput.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// -- Audio Sensitivity Card--
  Widget get audioInputSensitivityCard {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget("Sensitivity"),
              audioInputSensitivitySliderCard
            ],
          ),
        ),
      ),
    );
  }

  Widget get audioInputSensitivitySliderCard {
    return Container(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            audioInputSensitivitySlider,
            TextWidget(_audioInputSensitivity.floor().toString()),
//            SliderWidget(_audioInputSensitivity),
          ],
        ),
      ),
    );
  }

  /// -- Audio Input Sensitivity --
  /// Slider Display
  Widget get audioInputSensitivitySlider {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Slider(
              activeColor: Colors.white,
              min: 0.0,
              max: 100.0,
              onChanged: (value) {
                setState(() {
                  _audioInputSensitivity = value;
                });
                save('audioInputSensitivity', value);
              },
              value: _audioInputSensitivity,
            ),
          ],
        ));
  } //End widget

  /// -- Audio Card--
  /// Text Display
  Widget get videoInputCard {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget("Webcam Input"),
              videoInputDropBox,
            ],
          ),
        ),
      ),
    );
  }

  /// -- WebCam Input --
  /// DropBox Widget
  Widget get videoInputDropBox {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: DropdownButton<String>(
              value: _videoInput,
              icon: Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 1,
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white30,
              ),
              onChanged: (String value) {
                setState(() {
                  _videoInput = value;
                });
                save('videoInput', value);
              },
              // TODO: Look at getting audio options here
              items: _defaultVideoInput.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// -- Audio Card--
  /// Text Display
  Widget get audioInputIsMuteCard {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget("Mute Audio Input"),
              audioInputIsMuteToggle,
            ],
          ),
        ),
      ),
    );
  }

  /// -- Mute Microphone --
  /// ToggleButton Widget
  Widget get audioInputIsMuteToggle {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Switch(
            value: _audioInputIsMute,
            onChanged: (value) {
              setState(() {
                _audioInputIsMute = value;
              });
              save('audioInputIsMute', _audioInputIsMute);
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  /// -- Audio Card--
  /// Text Display
  Widget get audioOutputIsMuteCard {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget("Mute Audio Output"),
              audioOutputIsMuteToggle,
            ],
          ),
        ),
      ),
    );
  }

  /// -- Mute Headphone --
  /// ToggleButton Widget
  Widget get audioOutputIsMuteToggle {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Switch(
            value: _audioOutputIsMute,
            onChanged: (value) {
              setState(() {
                _audioOutputIsMute = value;
              });
              save('audioOutputIsMute', _audioOutputIsMute);
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  /// -- Audio Card--
  /// Text Display
  Widget get themeCard {
    return Container(
      child: Card(
//        color: Colors.lightGreen[800],
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Theme"),
            themeToggle,
          ],
        ),
      ),
    );
  }

  /// -- Mute Headphone --
  /// ToggleButton Widget
  Widget get themeToggle {
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
                      for (int i = 0; i < _themeIsSelected.length; i++) {
                        if (i == index) {
                          _themeIsSelected[i] = true;
                          changeBrightness();
//                          brightness: Brightness.dark,
                        } else {
                          _themeIsSelected[i] = false;
                          changeBrightness();
                        }
//                        _audioOutputIsMute = _audioOutputIsSelected[i];
//                        save('audioOutputIsMute', _audioOutputIsSelected[i]);
//                        save('audioOutputIsSelected', _audioOutputIsSelected[i]);
                      }
                    });
                  },
                  isSelected: _themeIsSelected,
                ),
              ],
            )),
      ],
    );
  }

  Widget user() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(FontAwesomeIcons.user, size: 44.0),
        ),
        Text(
          "User Account Name",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    );
  }//End widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: Colors.black26,
            child: user(),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  audioInCard,
                  audioOutCard,
                  audioInputSensitivityCard,
                  videoInputCard,
                  audioInputIsMuteCard,
                  audioOutputIsMuteCard,
                ],
              ),
            ),
          ),

        ],
      ),
    );
  } //End builder
} //End class
