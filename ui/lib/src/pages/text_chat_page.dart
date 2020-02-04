import 'package:flutter/material.dart';

class TextChatScreen extends StatefulWidget {
  @override
  State createState() => new _TextChatScreenState();
}

class _TextChatScreenState extends State<TextChatScreen>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposing = false;

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  /// -- Send a message --
  Widget _buildTextComposer() {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textEditingController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted: _handleSubmitted,
              decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textEditingController.text)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chat Screen"),
      ),
      body: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.1, 0.3, 0.5, 0.7, 0.9],
              colors: [
                Colors.lightGreen[900],
                Colors.lightGreen[800],
                Colors.lightGreen[700],
                Colors.lightGreen[500],
                Colors.lightGreen[300],
              ],
            ),
          ),
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          )),
    );
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
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
