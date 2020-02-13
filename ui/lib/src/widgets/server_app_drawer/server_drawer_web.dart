import 'package:flutter/material.dart';

import 'server_drawer.dart';

// TODO: Not Worried about this for awhile yet
class ServerDrawerWebPortrait extends StatelessWidget {
  const ServerDrawerWebPortrait({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(color: Colors.grey),
      child: Row(
        children: ServerDrawer.getDrawerOptions(),
      ),
    );
  }//End builder
}//End class

// PRIMARY CLASS FOR WEB VIEW ==================================================
class ServerDrawerWebLandscape extends StatelessWidget {
  const ServerDrawerWebLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 50)),
      child: Column(
        children: ServerDrawer.getDrawerOptions(),
      ),
    );
  }
}
