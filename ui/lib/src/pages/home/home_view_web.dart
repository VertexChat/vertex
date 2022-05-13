import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/layout_template/home_layout_template.dart';
import 'package:vertex_ui/src/widgets/main_app_widgets/app_navigation_bar.dart';
import 'package:vertex_ui/src/widgets/server_app_drawer/server_drawer.dart';

/// Class that builds the Home UI for web view
///
class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      //App drawer
      ServerDrawer(),
      Expanded(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: HomeLayoutTemplate(),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppNavigationBar(), // Top app bar
      body: Row(children: children),
    );
  } //End builder
} //End class
