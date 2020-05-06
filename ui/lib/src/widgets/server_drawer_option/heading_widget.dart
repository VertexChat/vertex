import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:vertex_ui/src/widgets/server_drawer_option/new_channel_dialog_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// This Widget is for creating a heading for the app drawer

class HeadingWidget extends StatelessWidget {
  final String headingText;

  const HeadingWidget({Key key, this.headingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final data = MediaQuery.of(context).size
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AutoSizeText(headingText,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return NewChannelDialog();
              },
            ),
          )
        ],
      ),
    );
  } //End builder
}

//End class
