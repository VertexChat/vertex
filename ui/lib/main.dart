import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/routing/router.dart';

/// Call to run App Root
void main() {
  // Run application start this class first
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

  @override
  void initState() {
    super.initState();
  }

  Brightness brightness;

  @override
  Widget build(BuildContext context) {
    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return new DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => ThemeData(
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Vertex',
          theme: ThemeData(brightness: Brightness.dark),
          home: SplashScreen(),
          // TODO: ${username}
          debugShowCheckedModeBanner: false,
          // Remove debug banner
          //Login route
          onGenerateRoute: Router.generateRoute,
          initialRoute:
              HomeRoute, // TODO: Implement auth first! Currently bypassing init loading screen
        );
      },
    );
  }
} //End class
