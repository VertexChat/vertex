import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/settings/constants.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';
import 'package:vertex_ui/src/pages/settings/audio_settings_model.dart';
import 'package:vertex_ui/src/pages/settings/audio_settings_card.dart';

/// Call to run App Root (App starts here)
void main() => runApp(UI()); // Vertex_UI -> App root call to

/// App Root
class UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertex',
      theme: ThemeData(brightness: Brightness.dark),
      home: VertexLanding(title: 'Vertex Landing Page'),
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

  VertexLanding({Key key, this.title}) : super(key: key);

  final String title;

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
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build),
            onPressed: _showSettingsPage,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.lightGreen[900],
              Colors.lightGreen[700],
              Colors.lightGreen[500],
              Colors.lightGreen[300],
            ],
          ),
        ),
        child: Center(
          child: Text("Fill me with widgets!"),
        ),
      ),
    );
  }

  // Any time you're pushing a new route and expect that route
  // to return something back to you,
  // you need to use an async function.
  // In this case, the function will create a form page
  // which the user can fill out and submit.
  // On submission, the information in that form page
  // will be passed back to this function.
  Future _showSettingsPage() async {
    AudioSettings audioSettings = await Navigator.of(context).push(
     MaterialPageRoute(
       builder: (BuildContext context){
         return SettingsPage("Settings Page");
       }
     ),
    );
  }
}
