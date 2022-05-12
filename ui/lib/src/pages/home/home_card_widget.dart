import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Variables
    return Expanded(
      child: Container(
        constraints: BoxConstraints.expand(), // Fill the screen area
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            // Friends with icon container.
            Container(
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.faceSmile,
                        ),
                        Text(
                          "Friends",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // Friend query heading
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Colors.black12,
                    onPressed: () => null,
                    child: Text("Online"),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Colors.black12,
                    onPressed: () => null,
                    child: Text("Pending"),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Colors.black12,
                    onPressed: () => null,
                    child: Text("Blocked"),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Colors.green,
                    onPressed: () => null,
                    child: Text("Add Friend"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //End builder
} //End class
