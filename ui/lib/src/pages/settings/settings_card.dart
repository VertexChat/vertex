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

  /// Need a few widgets
  /// First being a text widget
  Widget get displayInputDeviceText {
    return Container(
      // Can explicitly set heights and widths on containers
      width: 100.0,
      height: 100.0,

      child: Card(
          color: Colors.lightGreen[800],
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 64.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(widget.settings.inputDevice,
                    style: Theme.of(context).textTheme.headline),
                Text(widget.settings.outputDevice,
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          )),
    );
  }

  /// Secondly need a widget to handle the slider
  Widget get displayInputDeviceDropBox {
    return Container(
      // Can explicitly set heights and widths on containers
      width: 100.0,
      height: 100.0,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: displayInputDeviceText,
          ),
          Positioned(
            child: displayInputDeviceDropBox,
          ),
        ],
      ),
    );
  }
}
