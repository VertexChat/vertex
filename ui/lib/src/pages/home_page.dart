// VertexHomePage
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/example_data_screen.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

import 'login/login_page.dart';

/// Public --> StatefulWidget
class VertexHomePage extends StatefulWidget {
  final String title;
  final Settings settings; //TODO: Load from file in main.dart

  /// Home page of application.
  /// Fields in Widget subclass always marked final

  VertexHomePage({Key key, this.title, this.settings}) : super(key: key);

  @override
  _VertexHomePageState createState() => _VertexHomePageState();
}

/// Stateless class
class _VertexHomePageState extends State<VertexHomePage> {
  Settings settings;

  String title = "Welcome Home";

  Brightness brightness;

  bool isSwitched = true;

  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Scaffold: framework which implements the basic material
    /// design visual layout structure of the flutter app.
    /// Need one every time we build a new page
    return Scaffold(
      appBar: AppBar(
        /// Setting AppBar title here
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.trip_origin),
            onPressed: _showExampleDataPage,
          ),
          IconButton(
            icon: Icon(Icons.donut_small),
            onPressed: _showSplashScreenPage,
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: _showConnectCallPage,
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: _showTextChatPage,
          ),
          IconButton(
            icon: Icon(Icons.build),
            onPressed: _showSettingsPage,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.1, 0.3, 0.5, 0.7, 0.9],
            colors: [
              Colors.lightGreen[900],
              Colors.lightGreen[800],
              Colors.lightGreen[700],
              Colors.lightGreen[500],
              Colors.lightGreen[300],
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Display connect call page
  Future _showConnectCallPage() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ConnectCallPage("Connect to Video Call");
    }));
  } //End _showConnectCallPage()

  // Any time you're pushing a new route and expect that route
  // to return something back to you,
  // you need to use an async function.
  // In this case, the function will create a form page
  // which the user can fill out and submit.
  // On submission, the information in that form page
  // will be passed back to this function.
  Future _showSettingsPage() async {
    SettingsPage settingsPage = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsPage();
      }),
    );
  }

  Future _showTextChatPage() async {
    TextChatScreen textChatPage = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return TextChatScreen();
      }),
    );
  }

  // TODO: Remove from this class
  // This is for testing only!
  Future _showSplashScreenPage() async {
    SplashScreen _splashScreen = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SplashScreen();
      }),
    );
  }

  // _showExampleDataPage
  // TODO: Remove from this class
  // This is for testing only!
  Future _showExampleDataPage() async {
    ExampleDataScreen _showExampleData = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return ExampleDataScreen();
      }),
    );
  }
}
