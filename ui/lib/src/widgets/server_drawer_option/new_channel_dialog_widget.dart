import 'package:flutter/material.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
import 'package:vertex_ui/src/widgets/api_exception_alert_dialog.dart';

/// Class that builds a [Dialog] that is used as a [Form] to create
/// a new [Channel].

class NewChannelDialog extends StatefulWidget {
  const NewChannelDialog({Key key}) : super(key: key);

  @override
  _NewChannelDialogState createState() => _NewChannelDialogState();
}

class _NewChannelDialogState extends State<NewChannelDialog> {
  //Variables
  Channel channel = new Channel();
  static final _key = GlobalKey<FormState>();

  // Note, do not put these inside the build function and have the values reset on every
  // build like I did and spend hour debugging...
  Map<String, bool> values = {
    'TEXT': false,
    'VOICE': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'CREATE A NEW CHANNEL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22),
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: const Icon(Icons.create),
                  title: new TextFormField(
                    decoration: new InputDecoration(hintText: "Channel Name"),
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
                SizedBox(height: 30),
                Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: values.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: values[key],
                        onChanged: (bool value) {
                          setState(() {
                            values[key] = value;
                            this.channel.type = key;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog'),
                      ),
                      RaisedButton(
                        child: Text("CREATE"),
                        onPressed: () {
                          if (_key.currentState.validate())
                            _key.currentState.save();

                          //TODO - CB - Unhardcode the id
                          channel.id = 109;
                          // For testing --
                          print('Printing the channel data.');
                          print('Name: ${channel.name}');
                          print('Type: ${channel.type}');
                          print('ID: ${channel.id}');

                          postNewChannel(channel);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } //End builder

  /// Function to pass newly created [Channel] to
  /// [ChannelsViewModel] that looks after posting it to the database
  void postNewChannel(Channel channel) {
    locatorGlobal<ChannelsViewModel>()
        .addChannel(channel)
        .then((value) => Navigator.of(context).pop())
        .catchError((error) {
      showDialog(
          context: context,
          child: ApiExceptionAlertDialog(apiException: error));
    });
  } //End function
} //End class
