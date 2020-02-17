import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/widgets/app_navigation_bar.dart';
import 'package:vertex_ui/src/widgets/heading_widget.dart';
import 'package:vertex_ui/src/widgets/server_app_drawer/server_drawer.dart';

class HomeViewTablet extends StatelessWidget {
  const HomeViewTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      ServerDrawer(), //App drawer
      Expanded( // Main view
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    color: Color.fromRGBO(60, 60, 60, 20),
                    child: HeadingWidget(headingText: "Text Channel Name")),
              ]),
        ),
      ),
      // Left app drawer, this class will return the view in the correct orientation
    ];

    return Scaffold(
      appBar: AppNavigationBar(), // Top app bar
      body: Row(children: children),
    );
  }//End builder
}//End class
