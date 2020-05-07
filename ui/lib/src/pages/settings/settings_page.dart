import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/settings/settings_view_mobile.dart';
import 'package:vertex_ui/src/pages/settings/settings_view_web.dart';

/// Passing settings in from main.dart
/// Stateful widget receives data
/// It hands off data to Stateless widget
/// Stateless widget creates the widget from the data
/// It then passes it back to Stateful, who return the built widget
class SettingsPage extends StatefulWidget {
  // Immutable data -- Sort of.. this is the hand over, essentially just a temp ?
  final String title;
  final Settings settings;

  // Constructor
  SettingsPage({this.title, this.settings});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    /// Returns the layout type depending on the device the application is running on
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(desktop: 900, tablet: 650, watch: 250),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => SettingsViewMobilePortrait(),
      ),
      desktop: SettingsViewWeb(),
    );
  } //End builder
} //End class
