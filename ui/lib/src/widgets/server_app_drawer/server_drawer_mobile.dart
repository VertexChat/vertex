import 'package:flutter/material.dart';

import 'server_drawer.dart';

/// Class that will return the the drawer in the correct view for mobile

class ServerDrawerMobile extends StatelessWidget {
  const ServerDrawerMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 250 : 250,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(children: ServerDrawer.getDrawerOptions()),
    );
  } //End Builder
} //End class
