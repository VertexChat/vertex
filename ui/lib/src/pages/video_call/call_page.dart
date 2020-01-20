import 'package:flutter/material.dart';
import 'package:vertex_ui/main.dart';

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
          //TODO: Have everything below scale correctly on mobile devicesq
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Right video box
              // Added widgets to display video call will be added here
              new Container(
                  margin: const EdgeInsets.all(10.0),
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
                        //TODO: Check for camera on local system, that it is set correctly in settings
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
                    //TODO: Add over color so when the mouse is over the button it will light up to give a better feedback to the user
                    IconButton(
                      icon: Icon(Icons.call_end, size: 24.0),
                      onPressed: () => _endCall(),
                    ),
                    //Mute mic button
                    IconButton(
                      icon: Icon(Icons.mic, size: 24.0),
                      onPressed: () => _muteMic(),
                    ),
                    // Mute headset button
                    IconButton(
                        icon: Icon(Icons.headset, size: 24.0),
                        onPressed: () => _muteHeadset()),
                  ],
                ),
              )
            ],
          ),
        ));
  } //end Widget build

  //Function to end call and return to home page
  _endCall() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new VertexHomePage(title: "Welcome Home")));
  } //End function

  _muteMic() async {
    //TODO: need to connect with audio settings page I feel
  } //End function

  _muteHeadset() async {
    //TODO: need to connect with audio setting page I feel
  } //End function
} //End class
