import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
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
  static final _key = GlobalKey<FormState>();
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
                  style: Theme.of(context).textTheme.headline2),
              ChannelNavigationOptionsWidget(
                  channel: channel, isVoiceChannel: true),
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
                      Form(
                        key: _key,
                        child: TextFormField(
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
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please a channel name';
                            }
                          },
                          onSaved: (value) =>
                              setState(() => this.channel.name = value),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            child: Text(
                              "Delete Channel",
                              style: Theme.of(context).textTheme.headline3),
                            onPressed: () => _showWarningDialog(),
                          ),
                          ElevatedButton(
                            child: Text(
                              "UPDATE",
                              style: Theme.of(context).textTheme.headline2,

                            ),
                            onPressed: () {
                              if (_key.currentState.validate())
                                _key.currentState.save();
                              updatedChannel(channel.id, channel);
                            },
                          )
                        ],
                      )
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
              style: Theme.of(context).textTheme.headline3,),
          content: new Text(
              "Are you sure you want to delete '${channel.name}'? This cannot be undone."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            new TextButton(
              child: new Text(
                "Delete Channel",
                style: Theme.of(context).textTheme.headline2,
              ),
              onPressed: () => deleteChannel(channel.id),
            ),
          ],
        );
      },
    );
  } //end _showErrorDialog

  /// Function makes a update return to [ChannelsViewModel]
  /// where that will handle making the HTTP request and update the
  /// state of the Listens.User is navigated back to the [LandingPageRoute]
  //  /// Should an error occur and [AlertDialog] will display he error to the user
  void updatedChannel(int channelId, Channel channel) {
    locatorGlobal<ChannelsViewModel>()
        .updateChannel(channelId, channel)
        .then((value) =>
            locatorGlobal<NavigationServiceHome>().navigateTo(LandingPageRoute))
        .catchError((error) => showDialog(
            context: context,
            builder:  (BuildContext content) =>
                ApiExceptionAlertDialog(apiException: error)));
  }

  /// Function makes a delete request to the [ChannelsViewModel]
  /// where that will handle making the HTTP request and update the
  /// state of the Listens. User is navigated back to the [LandingPageRoute]
  /// Should an error occur and [AlertDialog] will display he error to the user
  void deleteChannel(int channelId) {
    locatorGlobal<ChannelsViewModel>()
        .deleteChannel(channelId)
        .then(
            (value) => Navigator.of(context, rootNavigator: true).pop('dialog'))
        .then((value) =>
            locatorGlobal<NavigationServiceHome>().navigateTo(LandingPageRoute))
        .catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext content) =>
              ApiExceptionAlertDialog(apiException: error));
    });
  }
} //End class
