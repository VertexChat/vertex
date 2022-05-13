import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/pages/base_view.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';
import 'package:vertex_ui/src/utils/equals.dart';
import 'package:vertex_ui/src/widgets/api_exception_alert_dialog.dart';
import 'package:vertex_ui/src/widgets/exception_alert_dialog.dart';

/// This class is used for building a [Widget] with a lists of voice channels
/// and text channels that are received from the database with the help of
/// [ChannelsViewModel] class. [buildBaseView] takes advantage of this class.
///
/// [NavigationServiceHome] is used to allow for navigation between
/// [VoiceChannelRoute] & [MessageRoute]
///
// https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter
// https://api.flutter.dev/flutter/widgets/ListView-class.html
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

class ServerDrawerListBuilder extends StatelessWidget {
  //Variables
  const ServerDrawerListBuilder({Key key}) : super(key: key);

  /// Function builds a list of Channels UI elements that the user can interact with.
  /// These elements are made with the [Channel.name] and [Channel.type]. The type will
  /// be used to display either a volume_up icon for voice channels or a message
  /// icon for text channels.
  ///
  /// The [ElevatedButton] onPressed event will [NavigationServiceHome] with the help
  /// of a [locatorGlobal] provider to navigate to [VoiceChannelRoute] or [MessageRoute]
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
            child: ElevatedButton(
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

  /// This [Widget] uses the [BaseView] class which converts this [StatelessWidget]
  /// into a [StatefulWidget] so it can pass a Function(t) that returns a model.
  /// In this class the [ChannelsViewModel] is needed as this widget builds a list of
  /// voice and text channels from that data received from [ChannelsViewModel.getChannels].
  ///
  /// Should an exceptions be throw during the [ChannelsViewModel.getChannels] the error
  /// is caught and a [AlertDialog] is displayed to the user informing them of an
  /// exception.
  ///
  /// The [BaseView.onModelReady] is super useful as now the UI element can know
  /// if it can display a progress indicator or the data depending on the [BaseModel.state].
  BaseView<ChannelsViewModel> buildBaseView(BuildContext context) {
    return BaseView<ChannelsViewModel>(
      onModelReady: (model) => model.getChannels().catchError((onError) {
        showDialog(
            context: context,
            builder: (BuildContext content) => onError == ApiException
                ? ApiExceptionAlertDialog(apiException: onError)
                : ExceptionAlertDialog(exception: onError));
      }), //Get channels
      builder: (context, model, child) {
        return model.state == ViewState.Idle
            ? _channelsListView(model.channels)
            : Center(child: CircularProgressIndicator());
      },
    );
  } //End builder

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[Expanded(child: buildBaseView(context))],
      ),
    );
  }
} //End class
