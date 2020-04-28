import 'package:flutter/material.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
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
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textEditingController = TextEditingController();
  final Channel channel;
  bool _isComposing = false;

  _TextChatScreenState({this.channel});

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  /// -- Send a message --
  Widget _buildTextComposer() {
    //  final _formKey = new GlobalKey<FormState>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              //  key: _formKey,
              controller: _textEditingController,
              onChanged: (String text) {
                setState(() => _isComposing = text.length > 0);
              },
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textEditingController.text)
                  : null,
            ),
          ),
        ],
      ),
    );
  } //End widget

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() => _isComposing = false);

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    setState(() => _messages.insert(0, message));
    message.animationController.forward();
  } //End function

  @override
  Widget build(BuildContext context) {
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
                ChannelNavigationOptionsWidget(channel: channel),
              ],
            ),
            //Heading
            Container(
              child: Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ));
  }
}

/// User name for displaying in message list
const String _name = "Morgan Reilly"; //TODO: Change this to current user

/// Handles displaying the message in the chat screen
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text), // Body of message to display
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(DateTime.now().minute.toString()),
            ),
          ],
        ),
      ),
    );
  } //End builder
} //End class
