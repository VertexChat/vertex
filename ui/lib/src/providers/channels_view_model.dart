import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/providers/base_model.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

/// This class handles the UI Channels business logical for CRUD operations, it
/// ties in with [ChannelApi]. This class extends [BaseModel] which handles
/// [notifyListeners]. When listing widgets are notified they will rebuild,
/// this allows for the abstraction of the UI and business logical.
///
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
/// https://dart.dev/guides/libraries/futures-error-handling

class ChannelsViewModel extends BaseModel {
  // Variables
  final _api = ChannelApi(); //Access to api
  List<Channel> _channels;

  List<Channel> get channels => _channels;

  bool _busy;

  bool get busy => _busy;

  //TODO - CB - Error handling
  /// Function uses the [ChannelApi] to get all channels in the database
  /// Function sets a state when the operation begins and when its
  /// completes, this allows the listeners to rebuild [notifyListeners]
  Future getChannels() async {
    setState(ViewState.Busy);
    var channelsData = await _api.getChannels();
    _channels = channelsData; // Update local channels list
    setState(ViewState.Idle);
  } //End getChannels function

  /// Function to add a new channel to the database.
  /// a new channel create within the UI is passed to the API
  /// to be sent onto the database
  Future addChannel(Channel channel) async {
    setState(ViewState.Busy);
    //POST new channel
    try {
      await _api.createChannel(channel);
      setState(ViewState.Idle); // update state
    } catch (ApiException) {
      print(ApiException);
      setState(ViewState.Idle);
      throw ApiException;
    }
    setState(ViewState.Idle); // update state
  }
} //End class
