import 'package:flutter/material.dart';

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

  // Set some default values
  String _inputDeviceValue = 'None Selected';
  String _outputDeviceValue = 'None Selected';
  double _inputSensitivityValue = 50.0;

  /// -- Input Device --
  ///
  /// Need a few widgets
  /// First being a text widget
  /// TODO: Rather than display all text in one widget
  /// TODO: Have a text header, then slider value in the one widget
  Widget get displayInputDeviceText {
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
                Text("Input Device: " + widget.settings.inputDevice,
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// Input Device Dropbox
  ///
  /// TODO: Manipulate for systems hardware
  Widget get displayInputDeviceDropBox {
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
                    value: _inputDeviceValue,
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
                        _inputDeviceValue = newOutputDeviceValue;
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

  /// Output Device Text
  ///
  ///
  Widget get displayOutputDeviceText {
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
                Text("Output Device: " + widget.settings.outputDevice,
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  /// Output Device Drop box
  Widget get displayOutputDeviceDropBox {
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
                    value: _outputDeviceValue,
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
                        _outputDeviceValue = newOutputDeviceValue;
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

  Widget get displayInputSensitivityText {
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
                    "Input Sensitivity: " +
                        widget.settings.inputSensitivity.toString(),
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

//  /// Secondly need a widget to handle the input sensitivity
  Widget get displayInputSensitivitySlider {
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
                          () => _inputSensitivityValue = newInputSensitivity);
                    },
                    value: _inputSensitivityValue,
                  ),
                ),

                // This displays the slider value
                Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_inputSensitivityValue.toInt()}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget get updateSettingsButton {
    return RaisedButton(
      onPressed: () => updateSettings(),
      child: Text('Save Settings'),
      color: Colors.lightGreen[700],
    );
  }

  void updateSettings() {
    setState(() {
      widget.settings.inputDevice = _inputDeviceValue;
      widget.settings.outputDevice = _outputDeviceValue;
      widget.settings.inputSensitivity = _inputSensitivityValue.toInt();
    });

    print('inputDevice: ' + widget.settings.inputDevice);
    print('outputDevice: ' + widget.settings.inputDevice);
    print('inputSensitivity: ' + widget.settings.inputSensitivity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
//      color: Colors.white12,
      height: 800.0,
      child: ListView(
        children: <Widget>[
          displayInputDeviceText,
          displayInputDeviceDropBox,
          displayOutputDeviceText,
          displayOutputDeviceDropBox,
          displayInputSensitivityText,
          displayInputSensitivitySlider,
          updateSettingsButton,
        ],
      ),
    );
  }
}
