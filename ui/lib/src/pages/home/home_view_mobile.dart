import 'package:flutter/material.dart';
import 'package:vertex_ui/src/widgets/app_drawer/app_drawer.dart';
import 'package:vertex_ui/src/widgets/custom_appbar.dart';
import 'package:vertex_ui/src/widgets/heading_widget.dart';

class HomeMobilePortrait extends StatefulWidget {
  HomeMobilePortrait({Key key}) : super(key: key);

  @override
  _HomeMobilePortrait createState() => _HomeMobilePortrait();
}

// PRIMARY CLASS FOR MOBILE ====================================================
class _HomeMobilePortrait extends State<HomeMobilePortrait> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          HeadingWidget(headingText: "Text Channel Name"),
          //More widgets to add here
        ],
      ),
    );
  }
}

class HomeMobileLandscape extends StatelessWidget {
  const HomeMobileLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[AppDrawer()],
      ),
    );
  }
}
