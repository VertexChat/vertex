import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key key,
    @required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(FontAwesomeIcons.user, size: 44.0),
            title: Text(userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: RaisedButton(
              child: Text("Logout"),
              color: Colors.red,
              onPressed: () => null,
            ),
          ),
        ],
      ),
    );
  } //End builder
} //End class
