import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/settings/constants.dart';
import 'package:vertex_ui/src/pages/settings/settings.dart';

/// Call to run App Root (App starts here)
void main() => runApp(UI()); // Vertex_UI -> App root call to

/// App Root
class UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertex',
      theme: ThemeData(
        /// App theme-ing here
        primarySwatch: Colors.green,
      ),
      home: VertexLanding(landingTitle: 'Vertex Landing Page'),

      /// Change this to splash-screen
      /// Landing screen should come later after Login
    );
  }
}

/// Each class defined below here is now a part of the App Root node
/// VertexLanding is currently main landing page, meaning the App will
/// load to that page.
/// Stateful class --> Stateful widget.
class VertexLanding extends StatefulWidget {
  /// Home page of application.
  /// Fields in Widget subclass always marked final

  VertexLanding({Key key, this.landingTitle}) : super(key: key);

  final String landingTitle;

  @override
  _VertexLandingState createState() => _VertexLandingState();
}

/// Stateless class
class _VertexLandingState extends State<VertexLanding> {

  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Scaffold: framework which implements the basic material
    /// design visual layout structure of the flutter app.
    return Scaffold(
      appBar: AppBar(
        /// Setting AppBar title here
        title: Text(widget.landingTitle),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              // loop through objects (map) and apply function
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList();
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsRoute()));
        },
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }
}
