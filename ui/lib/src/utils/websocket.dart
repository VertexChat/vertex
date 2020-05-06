import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';

/// WebSocket class used for connecting to eternal servers
/// This class handles connections for mobile devices

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

  SimpleWebSocket(this._url);

  connect() async {
    try {
      _socket = await _connectForSelfSignedCert(_url);
      this?.onOpen();

      _socket.listen((data) {
        this?.onMessage(data);
      }, onDone: () {
        this?.onClose(_socket.closeCode, _socket.closeReason);
      });
    } catch (e) {
      this.onClose(500, e.toString());
    }
  }

  /// Connect function to connect to a web socket server and keep to connection alive
  /// it will reconnect if it disconnect. This is designed to work with the [NotificationService]
  connectAndKeepAlive() async {
    reconnectScheduled = true;
    try {
      _socket = await _connectForSelfSignedCert(_url);

      this?.onOpen();

      _socket.listen((data) {
        this?.onMessage(data);
      }, onDone: () {
        this?.onClose(_socket.closeCode, _socket.closeReason);
        scheduleReconnect();
      });
    } catch (e) {
      this.onClose(500, e.toString());
      //scheduleReconnect();
    }
  }

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      new Timer(new Duration(milliseconds: 1000 * retrySeconds),
          () => connectAndKeepAlive());
    }
    reconnectScheduled = true;
  } //End function

  send(data) {
    if (_socket != null) {
      _socket.add(data);
//      print('send: $data');
    }
  }

  close() {
    _socket.close();
  }

  // https://stackoverflow.com/questions/53721745/dart-upgrade-client-socket-to-websocket
  Future<WebSocket> _connectForSelfSignedCert(url) async {

    try {
      Random r = new Random();
      String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
      SecurityContext securityContext = new SecurityContext();
      HttpClient client = HttpClient(context: securityContext);
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        print('Allow self-signed certificate => $host:$port. ');
        return true;
      };

      HttpClientRequest request =
          await client.getUrl(Uri.parse(url)); // form the correct url here
      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add(
          'Sec-WebSocket-Version', '13'); // insert the correct version here
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());
      //request.headers.add('Sec-WebSocket-Protocol', protocol);

      HttpClientResponse response = await request.close();
      print(response);

      Socket socket = await response.detachSocket();
      var webSocket = WebSocket.fromUpgradedSocket(
        socket,
        //  protocol: protocol,
        serverSide: false,
      );
      return webSocket;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
