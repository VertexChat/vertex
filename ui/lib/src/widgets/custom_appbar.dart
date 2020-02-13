import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

//https://stackoverflow.com/questions/53294006/how-to-create-a-custom-appbar-widget

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// Setting AppBar title here
      title: Text("Vertex"), //TODO: Removed hardcoded input
      //Added scaffoldKey so all child widgets can call on it
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.donut_small),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SplashScreen()));
          },
        ),
        IconButton(
          icon: Icon(Icons.video_call),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ConnectCallPage("Connect to a call")));
          },
        ),
        IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new TextChatScreen()));
          },
        ),
        IconButton(
          icon: Icon(Icons.build),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SettingsPage()));
          },
        ),
      ],
    );
  }
} //End class
