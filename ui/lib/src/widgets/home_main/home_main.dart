import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/example_data_screen.dart';
import 'package:vertex_ui/src/pages/settings_page.dart';
import 'package:vertex_ui/src/pages/splash_screen.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/pages/video_call/connect_call_page.dart';

import 'app_drawer/app_drawer.dart';
import 'custom_gradient.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMain createState() => _HomeMain();
}

class _HomeMain extends State<HomeMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        /// Setting AppBar title here
        title: Text("Vertex"), //TODO: Removed hardcoded input
        //Added scaffoldKey so all child widgets can call on it
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
          gradient: getCustomGradient(),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: Icon(Icons.menu, size: 30),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            )
          ],
        ),
      ),
    );
  } //End builder

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
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingsPage();
      }),
    );
  }

  Future _showTextChatPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return TextChatScreen();
      }),
    );
  }

  // TODO: Remove from this class
  // This is for testing only!
  Future _showSplashScreenPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SplashScreen();
      }),
    );
  }

  // _showExampleDataPage
  // TODO: Remove from this class
  // This is for testing only!
  Future _showExampleDataPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return ExampleDataScreen();
      }),
    );
  }
}
