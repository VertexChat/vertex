import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/src/widgets/server_drawer_option/heading_widget.dart';
import 'package:vertex_ui/src/widgets/server_drawer_option/server_drawer_list_builder.dart';

import 'server_drawer_mobile.dart';
import 'server_drawer_web.dart';

/// This class displays the server app drawer differently depending on the device the application
/// is running on. This is to allow for a response design across web, mobile & tablet with the aid of
/// [ResponsiveBuilder] & [ScreenTypeLayout]

class ServerDrawer extends StatelessWidget {
  const ServerDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Returns the layout type depending on the device the application is running on
    return ScreenTypeLayout(
      mobile: ServerDrawerMobile(),
      desktop: OrientationLayoutBuilder(
        portrait: (context) => ServerDrawerWebPortrait(),
        landscape: (context) => ServerDrawerWebLandscape(),
      ),
    );
  } //End widget builder

// Return app widgets that will display inside the left drawer
  static List<Widget> getDrawerOptions() {
    // These values will be populated from the server // TEST DATA
    return [
      // Elements that are displayed within the app drawer
      // Currently hard coded until server hock in
      kIsWeb
          ? Container()
          : SizedBox(
              height: 30,
            ),
      HeadingWidget(headingText: 'Vetex'),
      ServerDrawerListBuilder(),
      SizedBox(height: 50),
    ];
  } //End function =
} //End class
