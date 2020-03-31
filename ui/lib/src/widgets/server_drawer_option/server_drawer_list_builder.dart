import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/pages/base_view.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';
import 'package:vertex_ui/src/utils/equals.dart';

/// This class is used for building the lists of voice channels and text channels inside the
/// drawer. This class requires a list of [Channel] objects.
// https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter
// https://api.flutter.dev/flutter/widgets/ListView-class.html
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

class ServerDrawerListBuilder extends StatelessWidget {
  //Variables
  const ServerDrawerListBuilder({Key key}) : super(key: key);

  ListView _channelsListView(channelData) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: channelData == null ? 1 : channelData.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          //Display heading above the list
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                "CHANNELS",
                //data[index].listName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                overflow: TextOverflow.fade,
              ),
            ],
          );
        }
        index -= 1;
        // Display channels in container
        return Container(
            height: 40,
            child: RaisedButton(
                color: Colors.black26,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            equalsIgnoreCase(channelData[index].type, "VOICE")
                                ? Icons.volume_up
                                : Icons.message,
                            color: Colors.lightGreenAccent,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            channelData[index].name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onPressed: () =>
                    equalsIgnoreCase(channelData[index].type, "VOICE")
                        // Return Voice Channel information to VoiceCall() Page
                        ? locatorGlobal<NavigationServiceHome>().navigateTo(
                            VoiceChannelRoute,
                            arguments: channelData[
                                index]) // Pass channel data to VoiceCall
                        // Return Message Channel information to TextChatPage()
                        : locatorGlobal<NavigationServiceHome>().navigateTo(
                            MessageRoute,
                            arguments: channelData[index])));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  } //End ListView function

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: BaseView<ChannelsViewModel>(
            onModelReady: (model) => model.getChannels(), //Get channels
            builder: (context, model, child) {
              return model.state == ViewState.Idle
                  ? _channelsListView(model.channels)
                  : Center(child: CircularProgressIndicator());
            },
          ))
        ],
      ),
    );
  } //End builder
} //End class
