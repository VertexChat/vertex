import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// Widget that will create a card widget to display audio options for input device
/// or output devices depending on the parameters passed

class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {Key key,
      @required this.optionsDropdownBox,
      @required this.settingsTypeHeading,
      this.width})
      : super(key: key);

  // Dropbox widget either input || output for video or audio
  final Widget optionsDropdownBox;

  // String either input || output for video or audio
  final String settingsTypeHeading;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(settingsTypeHeading),
              optionsDropdownBox,
            ],
          ),
        ),
      ),
    );
  } //End builder
} //End class
