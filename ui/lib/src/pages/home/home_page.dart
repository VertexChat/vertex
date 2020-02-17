// VertexHomePage
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/home/home_view_mobile.dart';
import 'package:vertex_ui/src/pages/home/home_view_web.dart';

/// This class displays the UI differently depending on the device the application
/// is running on. This is to allow for a response design across web, mobile & tablet.
///
///
class VertexHomePage extends StatefulWidget {
  //Variables
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
  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Returns the layout type depending on the device the application is running on
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(desktop: 900, tablet: 650, watch: 250),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => HomeMobilePortrait(),
      ),
      desktop: HomeViewTablet(),
    );
  }
}
