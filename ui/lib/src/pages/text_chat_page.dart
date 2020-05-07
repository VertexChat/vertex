import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/pages/base_view.dart';
import 'package:vertex_ui/src/providers/message_view_model.dart';
import 'package:vertex_ui/src/widgets/api_exception_alert_dialog.dart';
import 'package:vertex_ui/src/widgets/exception_alert_dialog.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_name_widget.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_navigation_options_widget.dart';

class TextChatScreen extends StatefulWidget {
  final Channel channel;

  const TextChatScreen({Key key, @required this.channel}) : super(key: key);

  @override
  State createState() => _TextChatScreenState(channel: channel);
}

class _TextChatScreenState extends State<TextChatScreen>
    with TickerProviderStateMixin {
  //Variables
  final TextEditingController _textEditingController = TextEditingController();
  ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  AnimationController animationController;
  List<Message> localMessageList = [];
  SharedPreferences userDetails;
  var userApi = UserApi();
  final Channel channel;
  int userId;
  String username;
  String messageFromUser = " ";

  _TextChatScreenState({this.channel});

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    userDetails = await SharedPreferences.getInstance();
    userId = userDetails.getInt('id');
    username = userDetails.getString('username');
  }

  /// This [Widget] uses the [BaseView] class which converts this [StatelessWidget]
  /// into a [StatefulWidget] so it can pass a Function(t) that returns a model.
  /// In this class the [MessageViewModel] is needed as this widget builds a list of
  /// messages that are retrieved from [MessageViewModel.getMessages].
  ///
  /// Should an exceptions be throw during the [MessageViewModel.getMessages] the error
  /// is caught and a [AlertDialog] is displayed to the user informing them of an
  /// exception.
  ///
  /// The [BaseView.onModelReady] is super useful as now the UI element can know
  /// if it can display a progress indicator or the data depending on the [BaseModel.state].
  BaseView<MessageViewModel> buildBaseView(BuildContext context) {
    return BaseView<MessageViewModel>(
      onModelReady: (model) =>
          model.getMessages(channel.id).catchError((onError) {
        showDialog(
            context: context,
            child: onError == ApiException
                ? ApiExceptionAlertDialog(apiException: onError)
                : ExceptionAlertDialog(exception: onError));
      }), //Get channels
      builder: (context, model, child) {
        return model.state == ViewState.Idle
            ? _buildLayout(model.messages)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /// Widget to build main layout including the header bar and container
  /// of message.
  Widget _buildLayout(messages) {
    return Container(
        color: Colors.black26,
        child: Column(
          children: <Widget>[
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ChannelNameWidget(channel: channel),
                ChannelNavigationOptionsWidget(
                    channel: channel, isVoiceChannel: false),
              ],
            ),
            //Heading
            // list builder need a container and a flexible or else they give out a lot
            Container(
                child: Flexible(child: _buildMessageList(context, messages))),

            buildInput(),
          ],
        ));
  } //End layout

  /// Widget the build the text input container to allow a user compose a message
  /// to send.
  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  controller: _textEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  focusNode: focusNode,
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(_textEditingController.text),
                color: Colors.green,
              ),
            ),
            color: Colors.black26,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.black26),
    );
  }

  /// Function to make a call to [MessageViewModel] to send a new message
  /// [MessageViewModel.sendMessage]. Should any errors occur a [AlertDialog]
  /// will be displayed to notify the user of the exception.
  void onSendMessage(String content) {
    if (content.trim() != '') {
      _textEditingController.clear();

      Message message = new Message(
          channel: channel.id,
          author: userId,
          content: content,
          timestamp: DateTime.now().millisecondsSinceEpoch);

      localMessageList.add(message);
      locatorGlobal<MessageViewModel>()
          .sendMessage(channel.id, message)
          .catchError((onError) => showDialog(
              context: context,
              child: ApiExceptionAlertDialog(
                apiException: onError,
              )));

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {}
  }

  /// Widget to build UI message elements with their content inside them
  Widget buildItem(int index, message) {
    if (message.author == userId) {
      // Right (my message)
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 240.0,
            child: Text(
              message.content,
              style: TextStyle(color: Colors.green),
            ),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(
                bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Icon(
                        Icons.person,
                        size: 35.0,
                      )
                    : Container(width: 35.0),
                Container(
                  child: Text(
                    message.content,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 110,
                        ),
                        Text(
                          DateFormat('dd MMM kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  message.timestamp)),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  /// Function is used to check if the current message in the index is the
  /// last message on left. This is to help UI elements place text containers
  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            localMessageList != null &&
            localMessageList[index - 1].author == userId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Function is used to check if the current message in the index is the
  /// last message. This is to help UI elements place text containers
  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            localMessageList != null &&
            localMessageList[index - 1].author != userId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Widget that builds a list of messages with the help of
  /// [buildItem]
  Widget _buildMessageList(context, messageList) {
    //Populate local list
    localMessageList = messageList;

    //Sort messages by timestamp
    localMessageList.sort((b, a) => a.timestamp.compareTo(b.timestamp));

    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) => buildItem(index, messageList[index]),
      itemCount: messageList.length,
      reverse: true,
      controller: listScrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBaseView(context);
  }
} //End class
