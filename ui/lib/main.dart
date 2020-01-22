import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/login_register/login_page.dart';
import 'package:vertex_ui/src/pages/login_register/register_page.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';
import 'package:vertex_ui/src/pages/settings/audio_settings_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

/// Call to run App Root (App starts here)
void main() => runApp(UI()); // Vertex_UI -> App root call to

/// App Root
/// TODO: Change title to something more user meaningful
class UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return MaterialApp(
      title: 'Vertex',
      theme: ThemeData(brightness: Brightness.dark),
      home: VertexHomePage(title: 'Welcome Home'),
      // TODO: ${username}
      //Remove debug banner
      debugShowCheckedModeBanner: false,
      //Login route
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/register': (BuildContext context) => new RegisterPage()
      },

      // Accessibility Code -- Languages
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        // English
        const Locale('he'),
        // Hebrew
        const Locale.fromSubtags(languageCode: 'zh'),
        // Chinese *See Advanced Locales below*
      ],
    );
  }
}

/// Public --> StatefulWidget
class VertexHomePage extends StatefulWidget {
  /// Home page of application.
  /// Fields in Widget subclass always marked final
  VertexHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VertexHomePageState createState() => _VertexHomePageState();
}

/// Stateless class
class _VertexHomePageState extends State<VertexHomePage> {
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
            icon: Icon(Icons.build),
            onPressed: _showSettingsPage,
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: _showConnectCallPage,
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
    AudioSettings audioSettings = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsPage("Settings Page");
      }),
    );
  }
}
