import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vertex_ui/src/models/settings_model.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';
import 'package:vertex_ui/src/pages/video_call/video_call_page.dart';

/// This class is used to create a custom [AppBar] for this application.
/// This allows for navigation around the application
//https://stackoverflow.com/questions/53294006/how-to-create-a-custom-appbar-widget

class AppNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  AppNavigationBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  //Variables
  Settings settings;
  String title = "Vertex";
  Brightness brightness;
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// Setting AppBar title here
      title: Text(title), //TODO: Removed hardcoded input
//      automaticallyImplyLeading: false,
      //Added scaffoldKey so all child widgets can call on it
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.video_call),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new VideoCallPage()));
          },
        ),
        IconButton(
            icon: Icon(FontAwesomeIcons.user),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SettingsPage()));
            }),
        IconButton(
            icon: Icon(FontAwesomeIcons.lock),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new LoginPage()));
            })
      ],
    );
  }
} //End class
