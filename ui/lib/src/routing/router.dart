import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/home/home_page.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/routing/route_names.dart';

/// Switch statement that is used to return the page a user is trying to navigate to
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
        return _getPageRoute(VertexHomePage());
      case SettingsRoute:
        return _getPageRoute(SettingsPage());
      case LoginRoute:
        return _getPageRoute(LoginPage());
      case RegisterRoute:
        return _getPageRoute(RegisterPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    } //End switch
  } //End function

  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  } //End function

}
