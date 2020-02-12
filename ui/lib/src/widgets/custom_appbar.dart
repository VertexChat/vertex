import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/example_data_screen.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

class VertexAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// Setting AppBar title here
      title: Text("Vertex"), //TODO: Removed hardcoded input
      //Added scaffoldKey so all child widgets can call on it
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.trip_origin),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ExampleDataScreen()));
          },
        ),
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
