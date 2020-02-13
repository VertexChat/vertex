import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/src/widgets/drawer_option/drawer_list_view.dart';
import 'package:vertex_ui/src/widgets/drawer_option/drawer_navigation_bar.dart';

import '../heading_widget.dart';
import 'app_drawer_mobile.dart';
import 'app_drawer_web.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AppDrawerMobile(),
      desktop: OrientationLayoutBuilder(
        portrait: (context) => AppDrawerWebPortrait(),
        landscape: (context) => AppDrawerWebLandscape(),
      ),
    );
  } //End widget builder

// Return app widgets that will display inside the left drawer
  static List<Widget> getDrawerOptions() {
    // These values will be populated from the server // TEST DATA
    final List<String> testEntries = <String>[
      'Test channel 1',
      'Test channel 2',
      'Test channel 3'
    ];
    return [
      HeadingWidget(headingText: 'Server Name'),
      DrawerListView(
        items: testEntries,
      ),
      DrawerNavigationBar(),
    ];
  }
}
