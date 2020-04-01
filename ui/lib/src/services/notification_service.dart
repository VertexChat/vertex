import 'dart:convert';

import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';

import '../utils/websocket.dart'
    if (dart.library.js) '../utils/websocket_web.dart';

/// This service is for connecting to Vertex Notification server. The server will
/// notify users logged into the application of changes in the DB e.g new channel
/// added, or a new message has been sent in a text channel.
/// When a notification comes in the switch case will handle what listens to
/// notify within the application

class NotificationService {
  //Variables
  SimpleWebSocket _socket;
  JsonEncoder encoder = new JsonEncoder();
  JsonDecoder decoder = new JsonDecoder();
  var _sessionId = '60a9af55-ecc4-4250-9d99-9ee7c75da6fd'; //David
  //'32fa829b-652c-49b2-8fad-fdeb9689a61b'; // Cathals UUID -Testing
  var _host = "localhost";
  var _port = 8765;

  //Constructor
  NotificationService();

  void connect() async {
    var url = 'ws://$_host:$_port';
    _socket = SimpleWebSocket(url);

    print('Connect to $url');

    _socket.onOpen = () {
      //print('open');
      _send(_sessionId); //Send session id
    };

    _socket.onMessage = (message) {
      //print('Received Notification: ' + message);
      this.onMessage(decoder.convert(message));
    };

    _socket.onClose = (int code, String reason) {
      //print('Closed by server [$code => $reason]!');
    };

    await _socket.connect();
  } //End connect function

  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    switch (mapData['type']) {
      case 'get_channels':
        {
          // Update channels list
          // may require more data soon
          // lets the widget know to update
          await Future.delayed(const Duration(seconds: 10), () {});
          locatorGlobal<ChannelsViewModel>().addChannel();
          //notify.addChannel();
          break;
        }
      case 'get_message':
        {
          break;
        }
      default:
        //TODO - CB Complete this
        _send('Error');
    }
  }

  _send(data) {
    _socket.send(encoder.convert(data));
  }
} //End class
