import 'package:flutter/cupertino.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/providers/base_model.dart';
import 'package:vertex_ui/src/services/notification_service.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_members_widget.dart';

/// This class handles the UI Channels business logical for CRUD operations, it
/// ties in with [ChannelApi]. This class extends [BaseModel] which handles
/// [notifyListeners]. When listing widgets are notified using [setState]
/// they will rebuild rendering the new data.
///
/// Each view has it's own model that extends the [ChangeNotifier].
/// Each view only has 2 states. Idle and Busy. Any other piece of UI contained
/// in a view, that requires logic and state / UI updates will have it's own model
/// associated with it. This way the main view only paints when the main view state
/// changes. This Model will work in with [ChannelMembersWidget] as its [Widget]
/// needs access to the models channel data.
///
/// This architecture allows for the abstraction of the business logical from the
/// UI.s
///
/// This design is important for the application as the [NotificationService] will
/// notify the client that new data is available in the database. Please refer to the
/// [NotificationService] for more information about this

class MessageViewModel extends BaseModel {
  // Variables
  final _api = ChannelApi(); //Access to api
  //Members of a channel
  List<Message> _messages;
  List<Message> get messages => _messages;

  /// Future function to make a call to the API to get all [Message]s
  Future getMessages(int channelId) async {
    try {
      var message = await _api.getMessages(channelId);
      _messages = message;
      setState(ViewState.Idle);
    } catch (ApiException) {
      setState(ViewState.Idle);
      throw ApiException;
    }
  }

  Future sendMessage(int channelId, Message message) async {
    setState(ViewState.Busy);
    try {
      await _api.createMessage(channelId, message);
      setState(ViewState.Idle);
    } catch (ApiException) {
      setState(ViewState.Idle);
      throw ApiException;
    }
  }
} //End class
