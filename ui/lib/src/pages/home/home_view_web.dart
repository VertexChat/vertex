import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/widgets/app_drawer/app_drawer.dart';
import 'package:vertex_ui/src/widgets/custom_appbar.dart';
import 'package:vertex_ui/src/widgets/heading_widget.dart';

class HomeViewTablet extends StatelessWidget {
  const HomeViewTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    var children = [
      Expanded(
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
      AppDrawer()
    ];

    return Scaffold(
      appBar: CustomAppBar(), // Top app bar
      body: orientation == Orientation.portrait
          ? Column(children: children)
          : Row(children: children.reversed.toList()),
    );
  }
}
