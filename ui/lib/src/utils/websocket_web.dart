import 'dart:async';
import 'dart:html';

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

  connect() async {
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
      new Timer(
          new Duration(milliseconds: 1000 * retrySeconds), () => connect());
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
