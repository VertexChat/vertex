import 'package:flutter/material.dart';
import 'package:vertex_ui/localizations.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

/// Call to run App Root (App starts here)
void main() => runApp(UI()); // Vertex_UI -> App root call to

typedef void LocalChangedCallback(Locale locale);

class UI extends StatefulWidget {
  @override
  _UIState createState() => new _UIState();

}

/// App Root
class _UIState extends State<UI> {
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState(){
    super.initState();
    _specificLocalizationDelegate = SpecificLocalizationDelegate(new Locale("en"));
  }

  onLocaleChange(Locale locale){
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return MaterialApp(
      title: 'Vertex',
      theme: ThemeData(brightness: Brightness.dark),
      home: VertexHomePage(onLocaleChange, title: 'Welcome Home'), // TODO: ${username}

      // Accessibility Code -- Languages
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _specificLocalizationDelegate
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('ar'), // Arabic
      ],
      locale: _specificLocalizationDelegate.overriddenLocale,
    );
  }
}

/// Public --> StatefulWidget
class VertexHomePage extends StatefulWidget {
  /// Home page of application.
  /// Fields in Widget subclass always marked final

  VertexHomePage(this.callback, {Key key, this.title}) : super(key: key);

  LocalChangedCallback callback;
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
        title: Text(AppLocalizations.of(context).title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build),
            onPressed: _showSettingsPage,
          ),
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
    SettingsPage settingsPage = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsPage("Settings Page");
      }),
    );
  }
}
