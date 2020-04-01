import 'package:flutter/material.dart';

/// Class that builds a [AlertDialog] that is used as a [Form] to create
/// a new [Channel]

class NewChannelDialog extends StatelessWidget {
  const NewChannelDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return AlertDialog(
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'CREATE A NEW CHANNEL',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 50),
            ListTile(
              leading: const Icon(Icons.create),
              title: new TextField(
                decoration: new InputDecoration(hintText: "Channel Name"),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context, rootNavigator: true)
                        .pop('dialog'),
                  ),
                  RaisedButton(
                    child: Text("CREATE"),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
} //End class
