import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/video_call/call_page.dart';

//TODO: This page is currently temp till we discuses how we want it to look. It will prob be integrated somewhere down the line in the home page.

class ConnectCallPage extends StatefulWidget {
  //Member Variables
  final String landingTitle;

  /// Home page of application.
  /// Fields in Widget subclass always marked final
  ConnectCallPage(this.landingTitle);

  @override
  _ConnectCallPageState createState() => _ConnectCallPageState();
}

class _ConnectCallPageState extends State<ConnectCallPage> {
  //Member variables
  // https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller
  final _channelNameController = TextEditingController();
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Join a video channel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 2.0,
              width: MediaQuery.of(context).size.width / 2.0,
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                          // https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller
                          controller: _channelNameController,
                          decoration: InputDecoration(
                              errorText: _validateError
                              // If no name is entered
                                  ? "Channel name is mandatory"
                              // else return null
                                  : null,
                              // Hint message that displays in text dialog box
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1)),
                              hintText: 'Channel name'),
                        ))
                  ]),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () => onJoin(),
                              child: Text("Join"),
                              color: Colors.lightGreen[800],
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ))
                ],
              )),
        ));
  } // End widget builder

//  // Function to allow connection to a call once a channel name has been
//  // entered in the input dialog box
  onJoin() async {
    // update input validation
    setState(() {
      _channelNameController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelNameController.text.isNotEmpty) {
      //Navigate to another page
      Navigator.push(
          context,
          //Build mew page:
          MaterialPageRoute(
              builder: (context) =>
              new CallPage(pageTitle: _channelNameController.text, ip: null)));
    } //End function
  } //End ify
} //End class