import 'package:flutter/material.dart';
import 'package:vertex_ui/src/widgets/drawer_option/drawer_navigation_bar.dart';

import 'app_drawer.dart';

// TODO: Not Worried about this for awhile yet
class AppDrawerWebPortrait extends StatelessWidget {
  const AppDrawerWebPortrait({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(color: Colors.grey),
      child: Row(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }//End builder
}//End class

// PRIMARY CLASS FOR WEB VIEW ==================================================
class AppDrawerWebLandscape extends StatelessWidget {
  const AppDrawerWebLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(color: Color.fromRGBO(55, 55, 55, 50)),
      child: Column(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}
