import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/layout_template/home_layout_template.dart';
import 'package:vertex_ui/src/widgets/main_app_widgets/app_navigation_bar.dart';
import 'package:vertex_ui/src/widgets/server_app_drawer/server_drawer.dart';

/// Class that builds the Home UI for mobile devices in Portrait mode

class HomeMobilePortrait extends StatelessWidget {
  HomeMobilePortrait({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppNavigationBar(),
      drawer: ServerDrawer(),
      body: HomeLayoutTemplate(),
      //More widgets to add here
    );
  } //End Widget builder
} //End class
