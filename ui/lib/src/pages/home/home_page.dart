// VertexHomePage
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/home/home_view_mobile.dart';
import 'package:vertex_ui/src/pages/home/home_view_web.dart';

/// Public --> StatefulWidget
class VertexHomePage extends StatefulWidget {
  final String title;
  final Settings settings; //TODO: Load from file in main.dart

  /// Home page of application.
  /// Fields in Widget subclass always marked final
  VertexHomePage({Key key, this.title, this.settings}) : super(key: key);

  @override
  _VertexHomePageState createState() => _VertexHomePageState();
}

/// Stateless class
class _VertexHomePageState extends State<VertexHomePage> {
  //Variables
  Settings settings;
  String title = "Welcome Home";
  Brightness brightness;
  bool isSwitched = true;


  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Scaffold: framework which implements the basic material
    /// design visual layout structure of the flutter app.
    /// Need one every time we build a new page
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(desktop: 900, tablet: 650, watch: 250),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => HomeMobilePortrait(),
        landscape: (context) => HomeMobileLandscape(),
      ),
      desktop: HomeViewTablet(),
    );
  }
}
