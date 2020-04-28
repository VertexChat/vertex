import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

/// Function that will display a [AlertDialog] if
/// any errors occur during posting the new [Channel]
/// Requires [ApiException] & [BuildContext]

class ApiExceptionAlertDialog {
  final ApiException apiException;
  final BuildContext context;

  const ApiExceptionAlertDialog(
      {Key key, @required this.apiException, @required this.context});

  void displayDialog() {
    Map<String, dynamic> parsedError =
        json.decode(apiException.message.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Request Error"),
          content: new Text(parsedError['messages']),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } //end builder
} //End class
