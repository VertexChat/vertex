import 'package:flutter/material.dart';

// Class that displays icons of service a user can sign up with or login with.

class IconCard extends StatefulWidget {
  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<IconCard> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Image.asset('assets/icons/steam_icon.png'),
          iconSize: 42,
          onPressed: () {
            //TODO:
          },
        ),
        IconButton(
          icon: Image.asset('assets/icons/reddit_icon.png'),
          iconSize: 42,
          onPressed: () {
            //TODO:
          },
        ),
        IconButton(
          icon: Image.asset('assets/icons/twitch_icon.png'),
          iconSize: 42,
          onPressed: () {
            //TODO:
          },
        ),
        IconButton(
          icon: Image.asset('assets/icons/google_icon.png'),
          iconSize: 42,
          onPressed: () {
            //TODO:
          },
        )
      ],
    );
  } //end builder
} //end class