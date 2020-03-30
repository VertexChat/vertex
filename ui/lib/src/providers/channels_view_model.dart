import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/providers/base_model.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

/// This class handles the Channels business logical for CRUD operations
/// on channels in the application. This class [Extends] BaseModel which handles
/// notifying listens.
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

  Future getChannels() async {
    setState(ViewState.Busy);
    var channelsData = await _api.getAllChannels();
    _channels = channelsData; // Update list
    setState(ViewState.Idle);
  } //End getChannels function

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
