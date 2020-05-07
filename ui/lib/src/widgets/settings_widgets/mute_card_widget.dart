import 'package:flutter/material.dart';

import 'text_widget.dart';

class MuteCard extends StatelessWidget {
  const MuteCard(
      {Key key,
      @required this.audioMuteToggle,
      @required this.muteSourceTypeHeading})
      : super(key: key);

  /// Widget for either input mute or output mute
  final Widget audioMuteToggle;

  /// String heading for it either being input mute or output mute
  final String muteSourceTypeHeading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget(muteSourceTypeHeading),
              audioMuteToggle,
            ],
          ),
        ),
      ),
    );
  } //End builder
} //End class
