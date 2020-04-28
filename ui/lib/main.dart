import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/pages/layout_template/main_layout_template.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/routing/router.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

/// Main Class
void main() {
  // Run application start this class first
  setupLocator(); // Register Services with [GetIt]
//  NotificationService notificationService = new NotificationService();
//  notificationService.connect();
  runApp(UI());
}

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

/// App Root
class _UIState extends State<UI> {
  //Variables
  bool offline = false;
  Brightness brightness;
//  var api = AuthApi();
  Widget _defaultRoute = new LoginPage();

  @override
  Widget build(BuildContext context) {
//    bool _result = api.isLoggedIn;
    // if the user is logged in allow them access the home page
    //if (_result) _defaultRoute = new VertexHomePage();

    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return new DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => ThemeData(
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Vertex',
          theme: ThemeData(brightness: Brightness.dark),
          //home: _defaultRoute,
          debugShowCheckedModeBanner: false,
          // Build that will also handle routing for us as its built into flutter
          // Passing the MainLayout a child widget which is the view, this view will
          // be rendered
          // TODO: CB - Document this & ref
          builder: (context, child) => MainLayoutTemplate(child: child),
          // The child view return from the router
          navigatorKey: locatorGlobal<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: HomeRoute,
        );
      },
    );
  }
} //End class
