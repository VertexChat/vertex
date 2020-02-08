import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/home_page.dart';
import 'package:vertex_ui/src/pages/login_page.dart';
import 'package:vertex_ui/src/pages/register_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';

/// Call to run App Root (App starts here)
//void main() => runApp(UI()); // Vertex_UI -> App root call to
void main() {
  runApp(UI());
}

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

/// App Root
class _UIState extends State<UI> {
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
          // Remove debug banner
          debugShowCheckedModeBanner: false,
          //Login route
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => new LoginPage(),
            '/register': (BuildContext context) => new RegisterPage()
          },
        );
      },
    );
  }
}
