import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/providers/base_model.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
import 'package:vertex_ui/src/services/notification_service.dart';
import 'package:vertex_ui/src/widgets/server_drawer_option/server_drawer_list_builder.dart';

/// This class handles the UI Channels business logical for CRUD operations, it
/// ties in with [ChannelApi]. This class extends [BaseModel] which handles
/// [notifyListeners]. When listing widgets are notified using [setState]
/// they will rebuild rendering the new data.
///
/// Each view has it's own model that extends the [ChangeNotifier].
/// Each view only has 2 states. Idle and Busy. Any other piece of UI contained
/// in a view, that requires logic and state / UI updates will have it's own model
/// associated with it. This way the main view only paints when the main view state
/// changes. This Model will work in with [ServerDrawerListBuilder] as its [Widget]
/// needs access to the models channel data.
///
/// This architecture allows for the abstraction of the business logical from the
/// UI.
///
/// This design is important for the application as the [NotificationService] will
/// notify the client that new data is available in the database. Please refer to the
/// [NotificationService] for more information about this
///
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
/// https://dart.dev/guides/libraries/futures-error-handling

class ChannelsViewModel extends BaseModel {
  // Variables
  final _api = ChannelApi(); //Access to api
  //Channels
  List<Channel> _channels;

  List<Channel> get channels => _channels;

  /// Function uses the [ChannelApi] to get all channels in the database
  /// Function sets the state when the operation begins and when it
  /// completes, this allows the listeners to rebuild when [notifyListeners]
  /// is executed in the [setState] class.
  ///
  /// Should the server be down and no connection at all is available
  /// Dart throws a [ClientException] so that needs to be caught.
  /// No connection at all seems to only throw this exception.
  /// The rest are caught correctly using [ApiException]
  /// TODO - CB - Review this.
  Future getChannels() async {
    setState(ViewState.Busy);
    try {
      var channelsData = await _api.getChannels();
      _channels = channelsData; // Update local channels list
      setState(ViewState.Idle);
    } on ApiException {
      setState(ViewState.Idle);
      throw ApiException;
    } catch (ClientException) {
      setState(ViewState.Idle);
      throw ClientException;
    }
  } //End getChannels function

  /// Function to add a new channel to the database.
  /// a new channel create within the UI is passed to the API
  /// to be sent onto the database
  Future addChannel(Channel channel) async {
    setState(ViewState.Busy);
    //POST new channel
    try {
      await _api
          .createChannel(channel)
          .then((value) => getChannels()); //Get channels

      setState(ViewState.Idle); // update state
    } catch (ApiException) {
      setState(ViewState.Idle);
      throw ApiException;
    }
  }

  /// Future function to make a api request to delete a channel by its id
  Future deleteChannel(int channelId) async {
    setState(ViewState.Busy);
    try {
      await _api.deleteChannel(channelId).then((value) => getChannels());
      setState(ViewState.Idle);
    } catch (ApiException) {
      setState(ViewState.Idle);
      throw ApiException;
    }
  }
} //End class
