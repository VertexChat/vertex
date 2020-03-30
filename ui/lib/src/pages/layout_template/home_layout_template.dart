import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/routing/router.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

/// Layout template class that will allow for navigation of pages within a UI element
/// like a Container() or it can be used at the root of the application as well
/// if a main layout is implemented with a navigation bar.
/// For the use case of this application it will be used with the home page to allow
/// page changes inside the Expanded(Container()). This will allow for changing between
/// text messaging and in-current call page.

class HomeLayoutTemplate extends StatelessWidget {
  const HomeLayoutTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        children: <Widget>[
          Expanded(
            // Use the NavigationServiceHome to allow for navigation between
            // Voice call page and message.
            child: Navigator(
              key: locatorGlobal<NavigationServiceHome>().navigatorKey,
              onGenerateRoute: internalRoutes,
              initialRoute: LandingPageRoute,
            ),
          ),
        ],
      ),
    );
  } //End builder
} //End class
