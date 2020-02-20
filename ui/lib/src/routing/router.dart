import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/home/home_page.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';
import 'package:vertex_ui/src/routing/route_names.dart';

/// Switch statement that is used to return the page a user is trying to navigate to
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
        return _getPageRoute(VertexHomePage(), settings);
      case SettingsRoute:
        return _getPageRoute(SettingsPage(), settings);
      case LoginRoute:
        return _getPageRoute(LoginPage(), settings);
      case RegisterRoute:
        return _getPageRoute(RegisterPage(), settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    } //End switch
  } //End function

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => child, settings: settings);
  } //End function
}//End class
