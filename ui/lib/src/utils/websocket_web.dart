import 'dart:async';
import 'dart:html';

import 'package:vertex_ui/src/services/notification_service.dart';

/// Web WebSocket class, this class is called when the application is running on a
/// web browser client. The reasons for this is because Flutter Web is still in a beta
/// and the dart:html package is required.
/// Socket allows for connection to external services

typedef void OnMessageCallback(dynamic msg);
typedef void OnCloseCallback(int code, String reason);
typedef void OnOpenCallback();

class SimpleWebSocket {
  //Variables
  String _url;
  String _protocol;
  var _socket;
  OnOpenCallback onOpen;
  OnMessageCallback onMessage;
  OnCloseCallback onClose;
  var reconnectScheduled = false;
  int retrySeconds = 2;

  SimpleWebSocket(this._url) {
    _url = _url.replaceAll('https:', 'wss:');
  }

  /// Connect function to connect to a web socket server
  connect() async {
    try {
      _socket = WebSocket(_url);
      _socket.onOpen.listen((e) {
        this?.onOpen();
      });

      _socket.onMessage.listen((e) {
        this?.onMessage(e.data);
      });

      _socket.onClose.listen((e) {
        this?.onClose(e.code, e.reason);
      });
    } catch (e) {
      this?.onClose(e.code, e.reason);
    } //End try catch
  }

  /// Connect function to connect to a web socket server and keep to connection alive
  /// it will reconnect if it disconnect. This is designed to work with the [NotificationService]
  connectAndKeepAlive() async {
    reconnectScheduled = false;
    try {
      _socket = WebSocket(_url);
      _socket.onOpen.listen((e) {
        this?.onOpen();
      });

      _socket.onMessage.listen((e) {
        this?.onMessage(e.data);
      });

      _socket.onClose.listen((e) {
        this?.onClose(e.code, e.reason);
        scheduleReconnect(); //reconnect
      });
    } catch (e) {
      this?.onClose(e.code, e.reason);
      scheduleReconnect(); //reconnect
    } //End try catch
  } //End connect function

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      new Timer(new Duration(milliseconds: 1000 * retrySeconds),
          () => connectAndKeepAlive());
    }
    reconnectScheduled = true;
  } //End function

  /// Function to send data
  send(data) {
    if (_socket != null && _socket.readyState == WebSocket.OPEN) {
      _socket.send(data);
      print('send: $data');
    } else {
      print('WebSocket not connected, message $data not sent');
    }
  }

  /// Close WebSocket
  close() {
    _socket.close();
  }
} //End class
