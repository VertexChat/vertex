import 'package:flutter/material.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';
import 'package:vertex_ui/src/widgets/api_exception_alert_dialog.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_navigation_options_widget.dart';

/// This class build the EditChannel [Widget] page allowing a user update the channel name
/// or delete the channel
/// Class requires [Channel]

class EditChannel extends StatefulWidget {
  final Channel channel;

  const EditChannel({Key key, @required this.channel}) : super(key: key);

  @override
  _EditChannelState createState() => _EditChannelState(channel: channel);
}

class _EditChannelState extends State<EditChannel> {
  //Member Variables
  final Channel channel;

  _EditChannelState({Key key, this.channel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("CHANNEL OVERVIEW",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              ChannelNavigationOptionsWidget(channel: channel),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Text("CHANNEL NAME"),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: channel.name,
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      RaisedButton(
                        color: Colors.black26,
                        child: Text(
                          "Delete Channel",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _showWarningDialog(),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        )
      ]),
    );
  } // End builder

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Channel",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: new Text(
              "Are you sure you want to delete '${channel.name}'? This cannot be undone."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              padding: EdgeInsets.all(8.0),
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              padding: EdgeInsets.all(8.0),
              color: Colors.red,
              child: new Text(
                "Delete Channel",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                deleteChannel(channel.id);
              },
            ),
          ],
        );
      },
    );
  } //end _showErrorDialog

  /// Function makes a delete request to the [ChannelsViewModel]
  /// where that will handle making the HTTP reset and update the
  /// state of the Listens
  void deleteChannel(int channelId) {
    locatorGlobal<ChannelsViewModel>()
        .deleteChannel(channelId)
        .then(
            (value) => Navigator.of(context, rootNavigator: true).pop('dialog'))
        .then((value) =>
            locatorGlobal<NavigationServiceHome>().navigateTo(LandingPageRoute))
        .catchError((error) {
      ApiExceptionAlertDialog(apiException: error, context: context)
          .displayDialog();
    });
  }
} //End class
