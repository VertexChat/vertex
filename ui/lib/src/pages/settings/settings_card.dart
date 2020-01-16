import 'package:flutter/material.dart';

import 'settings_model.dart';

class SettingsCard extends StatefulWidget {
  final Settings settings;

  SettingsCard(this.settings);

  @override
  _SettingsCardState createState() => _SettingsCardState(settings);
}

class _SettingsCardState extends State<SettingsCard> {
  Settings settings;

  _SettingsCardState(this.settings);

  double _sliderValue = 10.0;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Input Device",
                    style: Theme.of(context).textTheme.headline),
                Text(widget.settings.inputDevice,
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          )),
    );
  }

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
                Text("Output Device:",
                    style: Theme.of(context).textTheme.headline),
                Text(widget.settings.outputDevice,
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          )),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Input Sensitivity",
                    style: Theme.of(context).textTheme.headline),
                Text(widget.settings.inputSensitivity.toString(),
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          )),
    );
  }

//  /// Secondly need a widget to handle the input sensitivity
//  Widget get displayInputSensitivitySlider {
//    return Column(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.symmetric(
//            vertical: 16.0,
//            horizontal: 16.0,
//          ),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Flexible(
//                flex: 1,
//                child: Slider(
//                  activeColor: Colors.lightGreen,
//                  min: 0.0,
//                  max: 100.0,
//                  onChanged: (newInputSensitivity) {
//                    setState(() => _sliderValue = newInputSensitivity);
//                  },
//                  value: _sliderValue,
//                ),
//              ),
//
//              // This displays the slider value
//              Container(
//                width: 50.0,
//                alignment: Alignment.center,
//                child: Text('${_sliderValue.toInt()}', style: Theme.of(context).textTheme.display1,),
//              )
//            ],
//          )
//        ),
//      ],
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
//      color: Colors.white,
      height: 800.0,
      child: ListView(
        children: <Widget>[
          displayInputDeviceText,
          displayOutputDeviceText,
          displayInputSensitivityText,
        ],
      ),
    );
  }
}
