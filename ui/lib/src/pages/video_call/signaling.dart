import 'dart:convert';
import 'dart:async';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:vertex_ui/src/services/random_string.dart';

import '../../utils/turn.dart' if (dart.library.js) '../../utils/turn_web.dart';

import '../../utils/device_info.dart'
    if (dart.library.js) '../../utils/device_info_web.dart';

import '../../utils/websocket.dart'
    if (dart.library.js) '../../utils/websocket_web.dart';

/// Enum for different states
enum SignalingState {
  CallStateNew, // New call
  CallStateRinging, // Ringing
  CallStateInvite, //Invite to call
  CallStateConnected, // Connected to call
  CallStateBye, // End call 'bye'
  ConnectionOpen, // Open call
  ConnectionClosed, // Connection closed
  ConnectionError, // Connection error
}

/// https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Connectivity

/*
 * callbacks for Signaling API.
 */
typedef void SignalingStateCallback(SignalingState state);
typedef void StreamStateCallback(MediaStream stream);
typedef void OtherEventCallback(dynamic event);
typedef void DataChannelMessageCallback(
    RTCDataChannel dc, RTCDataChannelMessage data);
typedef void DataChannelCallback(RTCDataChannel dc);

class Signaling {
  // Variables
  String _selfId = randomNumeric(6); // Random Number is generated for id
  SimpleWebSocket _socket; // WebSocket
  var _sessionId;
  var _host;
  var _port = 8086;

  /// Provides methods to connect to a remote peer, maintain and monitor the
  /// connection, and close the connection once it's no longer needed.
  var _peerConnections = new Map<String, RTCPeerConnection>();

  // The RTCDataChannel interface represents a network channel which can be used
  // for bidirectional peer-to-peer transfers of arbitrary data. Every data channel
  // is associated with an RTCPeerConnection, and each peer connection can have up
  // to a theoretical maximum of 65,534 data channels (the actual limit may vary
  // from browser to browser).
  var _dataChannels = new Map<String, RTCDataChannel>();

  /// Users in the channel
  var _remoteCandidates = [];

  // Local client stream
  MediaStream _localStream;

  // Remote user stream
  List<MediaStream> _remoteStreams;

  // State Change callback
  SignalingStateCallback onStateChange;

  // Local state callback
  StreamStateCallback onLocalStream;

  // Remote state callback
  StreamStateCallback onAddRemoteStream;
  StreamStateCallback onRemoveRemoteStream;

  // Peer updates
  OtherEventCallback onPeersUpdate;

  // Channel message callback
  DataChannelMessageCallback onDataChannelMessage;

  // Channel callback
  DataChannelCallback onDataChannel;

  // https://anyconnect.com/stun-turn-ice/
  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  // True for audio and video
  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };

  // False for audio and video
  final Map<String, dynamic> _dc_constraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  //Constructor
  Signaling(this._host);

  close() {
    if (_localStream != null) {
      _localStream.dispose();
      _localStream = null;
    }

    _peerConnections.forEach((key, pc) {
      pc.close();
    });
    if (_socket != null) _socket.close();
  }

  void switchCamera() {
    if (_localStream != null) {
      _localStream.getVideoTracks()[0].switchCamera();
    }
  }

  /// Function to invite a peer
  void invite(String peerId, String media, useScreen) {
    // Create a session id from selfId and peer id:
    this._sessionId = this._selfId + '-' + peerId;

    if (this.onStateChange != null) {
      this.onStateChange(SignalingState.CallStateNew);
    }

    // Create a new peer connection from the selected peer in the list:
    _createPeerConnection(peerId, media, useScreen).then((pc) {
      //Add peer to list of peer connections
      _peerConnections[peerId] = pc;

      // Start a data channel is media options is data:
      if (media == 'data') _createDataChannel(peerId, pc);

      // Create an offer to the peer
      _createOffer(peerId, pc, media);
    });
  } //End invite

  void bye() {
    _send('bye', {
      'session_id': this._sessionId,
      'from': this._selfId,
    });
  }

  /// Function which handles incoming messages from the websocket
  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    // List of peers returned from server including myself
    var data = mapData['data']; // Data from message
    switch (mapData['type']) {
      // Type from message
      case 'peers':
        {
          List<dynamic> peers = data;
          // print("inside peer, printing peer data  " + data);
          if (this.onPeersUpdate != null) {
            Map<String, dynamic> event = new Map<String, dynamic>();
            event['self'] = _selfId;
            event['peers'] = peers;
            this.onPeersUpdate(event);
          }
        }
        break;
      case 'offer':
        {
          var id = data['id'];
          var description = data['description'];
          var media = data['media'];
          var sessionId = data['session_id'];
          this._sessionId = sessionId;

          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateNew);
          }

          var pc = await _createPeerConnection(id, media, false);
          _peerConnections[id] = pc; // set peer connection

          //Set remote description
          await pc.setRemoteDescription(new RTCSessionDescription(
              description['sdp'], description['type']));

          //Send a answer request to the peer that made an offer:
          await _createAnswer(id, pc, media);

          if (this._remoteCandidates.length > 0) {
            _remoteCandidates.forEach((candidate) async {
              await pc.addCandidate(candidate);
            });
            _remoteCandidates.clear();
          }
        }
        break;
      case 'answer':
        {
          var id = data['id'];
          var description = data['description'];

          print('insdie answer' + id);
          var pc = _peerConnections[id];
          if (pc != null) {
            await pc.setRemoteDescription(new RTCSessionDescription(
                description['sdp'], description['type']));
          }
        }
        break;
      case 'candidate':
        {
          var id = data['id'];
          var candidateMap = data['candidate'];
          var pc = _peerConnections[id];

          RTCIceCandidate candidate = new RTCIceCandidate(
              candidateMap['candidate'],
              candidateMap['sdpMid'],
              candidateMap['sdpMLineIndex']);
          if (pc != null) {
            await pc.addCandidate(candidate);
          } else {
            _remoteCandidates.add(candidate);
          }
        }
        break;
      case 'leave':
        {
          var id = data;
          var pc = _peerConnections.remove(id);
          _dataChannels.remove(id);

          if (_localStream != null) {
            _localStream.dispose();
            _localStream = null;
          }

          if (pc != null) {
            pc.close();
          }
          this._sessionId = null;
          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateBye);
          }
        }
        break;
      case 'bye':
        {
          var to = data['to'];
          var sessionId = data['session_id'];
          print('bye: ' + sessionId);

          if (_localStream != null) {
            _localStream.dispose();
            _localStream = null;
          }

          var pc = _peerConnections[to];
          if (pc != null) {
            pc.close();
            _peerConnections.remove(to);
          }

          var dc = _dataChannels[to];
          if (dc != null) {
            dc.close();
            _dataChannels.remove(to);
          }

          this._sessionId = null;
          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateBye);
          }
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      default:
        break;
    }
  }

  void connect() async {
    var url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(url);

    print('connect to $url');

    // Send data about myself on connection to signaling server
    _socket.onOpen = () {
      print('onOpen');
      this?.onStateChange(SignalingState.ConnectionOpen);
      _send('new', {
        'name': DeviceInfo.label,
        'id': _selfId,
        'user_agent': DeviceInfo.userAgent
      });
    };

    _socket.onMessage = (message) {
      print('Recivied data: ' + message);
      JsonDecoder decoder = new JsonDecoder();
      this.onMessage(decoder.convert(message));
    };

    _socket.onClose = (int code, String reason) {
      print('Closed by server [$code => $reason]!');
      if (this.onStateChange != null) {
        this.onStateChange(SignalingState.ConnectionClosed);
      }
    };
    await _socket.connect();
  } //End connect function

  Future<MediaStream> createStream(media, userScreen) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth':
              '640', // Provide your own width, height and frame rate here
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    MediaStream stream = userScreen
        ? await navigator.getDisplayMedia(mediaConstraints)
        : await navigator.getUserMedia(mediaConstraints);

    //https://stackoverflow.com/questions/35512314/how-to-mute-unmute-mic-in-webrtc
    stream.getAudioTracks()[0].enabled = true;

    if (this.onLocalStream != null) {
      this.onLocalStream(stream);
    }
    return stream;
  }

  _createPeerConnection(id, media, userScreen) async {
    if (media != 'data') _localStream = await createStream(media, userScreen);

    RTCPeerConnection pc = await createPeerConnection(_iceServers, _config);

    if (media != 'data') pc.addStream(_localStream);

    pc.onIceCandidate = (candidate) {
      _send('candidate', {
        'to': id,
        'id': _selfId,
        'candidate': {
          'sdpMLineIndex': candidate.sdpMlineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate,
        },
        'session_id': this._sessionId,
      });
    };

    pc.onIceConnectionState = (state) {
      print(state.toString());
    };

    pc.onAddStream = (stream) {
      if (this.onAddRemoteStream != null) this.onAddRemoteStream(stream);
      //_remoteStreams.add(stream);
    };

    pc.onRemoveStream = (stream) {
      if (this.onRemoveRemoteStream != null) this.onRemoveRemoteStream(stream);
      _remoteStreams.removeWhere((it) {
        return (it.id == stream.id);
      });
    };

    pc.onDataChannel = (channel) {
      _addDataChannel(id, channel);
    };
    return pc;
  } //End peer connection

  _addDataChannel(id, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};
    channel.onMessage = (RTCDataChannelMessage data) {
      if (this.onDataChannelMessage != null)
        this.onDataChannelMessage(channel, data);
    };
    _dataChannels[id] = channel;

    if (this.onDataChannel != null) this.onDataChannel(channel);
  }

  _createDataChannel(id, RTCPeerConnection pc, {label: 'fileTransfer'}) async {
    RTCDataChannelInit dataChannelDict = new RTCDataChannelInit();
    RTCDataChannel channel = await pc.createDataChannel(label, dataChannelDict);
    _addDataChannel(id, channel);
  } //End function

  // Function to Create a peer connection with a remote user
  _createOffer(String id, RTCPeerConnection pc, String media) async {
    try {
      // This interface describes one end of a connection by creating an offer
      // with constrains passed of what type of connection it is:
      RTCSessionDescription s = await pc
          .createOffer(media == 'data' ? _dc_constraints : _constraints);
      // Update local description
      pc.setLocalDescription(s);

      // Send offer
      _send('offer', {
        'to': id,
        'id': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': this._sessionId,
        'media': media,
      });
    } catch (e) {
      print(e.toString());
    }
  } //End _createOffer function

  _createAnswer(String id, RTCPeerConnection pc, media) async {
    try {
      // Create a session
      RTCSessionDescription s = await pc
          .createAnswer(media == 'data' ? _dc_constraints : _constraints);
      pc.setLocalDescription(s);

      _send('answer', {
        'to': id,
        'id': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': this._sessionId,
      });
    } catch (e) {
      print(e.toString());
    }
  } //End function

  _send(event, data) {
    var request = new Map();
    request["type"] = event; // Event type
    request["data"] = data; // Data with event type
    JsonEncoder encoder = new JsonEncoder();
    _socket.send(encoder.convert(request));
  } //End function
} //End class
