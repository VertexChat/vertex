import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

/// Call to run App Root (App starts here)
void main() => runApp(UI()); // Vertex_UI -> App root call to

class UI extends StatefulWidget {
  @override
  _UIState createState() => new _UIState();
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
      data: (brightness) => new ThemeData(
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Vertex',
          theme: ThemeData(brightness: Brightness.dark),
          home: VertexHomePage(title: 'Welcome Home'),
          // TODO: ${username}
          debugShowCheckedModeBanner: false,
          // Remove debug banner
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
            icon: Icon(Icons.video_call),
            onPressed: _showConnectCallPage,
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
        )),
      ),
    );
  }

  //Display connect call page
  Future _showConnectCallPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ConnectCallPage("Connect to Video Call")));
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
}
