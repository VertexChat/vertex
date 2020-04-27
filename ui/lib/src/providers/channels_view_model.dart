import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/providers/base_model.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

/// This class handles the UI Channels business logical for CRUD operations, it
/// ties in with [ChannelApi]. This class extends [BaseModel] which handles
/// [notifyListeners]. When listing widgets are notified they will rebuild,
/// this allows for the abstraction of the UI and business logical.
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

class ChannelsViewModel extends BaseModel {
  // Variables
  final _api = ChannelApi(); //Access to api
  List<Channel> _channels;
  List<Channel> get channels => _channels;

  bool _busy;
  bool get busy => _busy;

  String _errorMessage;
  String get errorMessage => _errorMessage;

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
  void addChannel() async {
    setState(ViewState.Busy);

    //Testing
//    Channel channel = new Channel();
//    channel.id = 832;
//    channel.name = "n00bss";
//    channel.type = "VOICE";
//    channel.capacity = 20;
//    channel.position = 1;
//    channel.userId = 3;

//    _api.addChannel(channel: channel);
//    await Future.delayed(const Duration(seconds: 3), () {});
//    getChannels();
    
    setState(ViewState.Idle);
  }


} //End class
