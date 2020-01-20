import 'package:flutter/material.dart';

/// Each class defined below here is now a part of the App Root node
/// VertexLanding is currently main landing page, meaning the App will
/// load to that page.
/// Stateful class --> Stateful widget.
class CallPage extends StatefulWidget {
  //Member Variables
  final String pageTitle;

  /// Home page of application.
  /// Fields in Widget subclass always marked final
  CallPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

/// Stateless class
class _CallPageState extends State<CallPage> {
  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Scaffold: framework which implements the basic material
    /// design visual layout structure of the flutter app.
    return Scaffold(
        appBar: AppBar(

            /// Setting AppBar title here
            title: Text(
          widget.pageTitle,
          style: TextStyle(color: Colors.white),
        )),

        /// Center: A widget that centers all children within it
        body: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Right video box
              // Added widgets to display video call will be added here
              new Container(
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.blue,
                  //Setting percentage amount of height & width
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: Center(
                    // Center all content 'Center'
                    child: Text('External Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                  )),
              // Left video box
              // Added widgets to display video call will be added here
              new Container(
                  alignment: Alignment.topRight,
                  padding:
                      new EdgeInsets.only(top: 10, right: 20.0, left: 20.0),
                  child: new Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.black,
                      width: 500,
                      height: 300,
                      child: Center(
                        // Center all content 'Center'
                        child: Text('Local Camera',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ))),
              new Container(
                //Container for the icons
                margin: const EdgeInsets.all(30.0),
                alignment: Alignment.bottomCenter,
                child: new Row(
                  //Row on icons inside the container
                  //Container for call fanatically buttons
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.call_end,
                      size: 24.0,
                    ),
                    Icon(Icons.mic, size: 24.0),
                    Icon(Icons.headset, size: 24.0)
                  ],
                ),
              )
            ],
          ),
        ));
  } //end Widget build
} //End class
