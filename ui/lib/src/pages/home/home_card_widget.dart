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
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                      ],
                    ),
                  ),
                  // Friend query heading
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => null,
                      child: Text("Online"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => null,
                    child: Text("Pending"),
                  ),
                  ElevatedButton(
                    onPressed: () => null,
                    child: Text("Blocked"),
                  ),
                  ElevatedButton(
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
