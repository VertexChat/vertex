import 'dart:async';
import 'dart:convert';

import 'package:flutter_webrtc/webrtc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/enums/signaling_state_enum.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

import '../utils/device_info.dart'
    if (dart.library.js) '../utils/device_info_web.dart';
import '../utils/websocket.dart'
    if (dart.library.js) '../utils/websocket_web.dart';

/// https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Connectivity

///Callbacks for Signaling API.
///
typedef void SignalingStateCallback(SignalingState state);
typedef void StreamStateCallback(MediaStream stream);
typedef void OtherEventCallback(dynamic event);
typedef void DataChannelMessageCallback(
    RTCDataChannel dc, RTCDataChannelMessage data);
typedef void DataChannelCallback(RTCDataChannel dc);

class Signaling {
  // Variables
  JsonDecoder decoder = new JsonDecoder();
  JsonEncoder encoder = new JsonEncoder();
  SharedPreferences _userDetails;
  SimpleWebSocket _socket; // WebSocket
  List<dynamic> peers;
  String _username;
  String _selfId; // Random Number is generated for id
  var _sessionId;
  var _port = 8086;
  var _host;

  /// Provides methods to connect to a remote peer, maintain and monitor the
  /// connection, and close the connection once it's no longer needed.
  var _peerConnections = new Map<String, RTCPeerConnection>();

  /// Users in the channel
  var _remoteCandidates = [];

  // Local client stream
  // Remote user stream
  MediaStream _localStream;
  List<MediaStream> _remoteStreams;

  // State Change callback
  // Local state callback
  SignalingStateCallback onStateChange;
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

  /// this will no longer be needed by chrome
  /// eventually (supposedly), but is necessary
  /// for now to get firefox to talk to chrome */
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

  final Map<String, dynamic> _voiceConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': false, // No video
    },
    'optional': [],
  };

  //Constructor
  Signaling(this._host);

  /// Function that mutes the [_localStream] mic.
  void muteMic(bool mute) {
    if (_localStream != null) {
      _localStream.getAudioTracks()[0].setMicrophoneMute(mute);
    }
  }

  /// Function that changes the [_localStream] camera.
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
      // Create an offer to the peer
      _createOffer(peerId, pc, media);
    });
  } //End invite

  /// Function for connection to the signaling server.
  /// instances of [SimpleWebSocket] is created that connects to the server.
  /// [_socket] events are and states are updated to notify the application
  /// of events taking place. [SignalingState]
  void connect() async {
    //Variables
    _userDetails = await SharedPreferences.getInstance();
    var url = 'https://$_host/ws';

    // Set connecting state
    this.onStateChange(SignalingState.ConnectionConnecting);

    _socket = SimpleWebSocket(url);

    /// Grab user details from [SharedPreferences]
    /// User id and username. ID are unique, by the minor chance [SharedPreferences]
    /// does not handle user details correct the user with be return to [LoginRoute]
    if (_selfId == _userDetails.getInt('id').toString()) {
      locatorGlobal<NavigationService>().navigateTo(LoginRoute);
    } else {
      _selfId = _userDetails.getInt('id').toString();
      _username = _userDetails.getString('username');
    }
    print('connect to $url');

    // Send data about myself on connection to signaling server
    _socket.onOpen = () async {
      print('onOpen');
      this?.onStateChange(SignalingState.ConnectionOpen);
      this?.onStateChange(SignalingState.FetchingData);

      //Needs to give time for the server to remove the old connection
      await new Future.delayed(const Duration(seconds: 2));

      _send('new', {
        'device_name': DeviceInfo.label,
        'id': _selfId,
        'username': _username,
        'user_agent': DeviceInfo.userAgent
      });
    };

    _socket.onMessage = (message) {
      this?.onStateChange(SignalingState.ReceivedData);
      print(message);
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

  /// Function which handles all incoming messages from the [_socket].
  /// Messages are processed by there type which is an event.
  /// The cases will process the data updating local state or replying to the signalling
  /// server.
  void onMessage(message) async {
    //Variables
    Map<String, dynamic> mapData = message;
    var data = mapData['data']; // Data from message
    List<dynamic> peers;

    switch (mapData['type']) {
      // Type from message
      case 'peers':
        {
          peers = data; //Update list of peers
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

          this._sessionId = null;
          if (this.onStateChange != null) {
            this.onStateChange(SignalingState.CallStateBye);
          }
        }
        break;
      default:
        break;
    }
  }

  /// Function looks after closing [_localStream] and closing [_peerConnections] streams
  /// the socket is closed along with the stream.
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

  /// Fruition creates and returns a [MediaStream]. Depending on the
  /// [media] type it will return the constraints needed for that media type.
  Future<MediaStream> createStream(media, userScreen) async {
    //Variables
    Map<String, dynamic> mediaConstraints;
    final Map<String, dynamic> mediaConstraintsVideo = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '640',
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    /// Voice Call media constrains, only audio enable.
    final Map<String, dynamic> mediaConstraintsVoice = {
      'audio': true,
      'video': false
    };

    /// Returns the constrains needed depending on the media type
    if (media == 'voice') {
      mediaConstraints = mediaConstraintsVoice;
    } else {
      mediaConstraints = mediaConstraintsVideo;
    }

    /// Get media stream
    MediaStream stream = userScreen
        ? await navigator.getDisplayMedia(mediaConstraints)
        : await navigator.getUserMedia(mediaConstraints);

    if (this.onLocalStream != null) {
      this.onLocalStream(stream);
    }
    return stream;
  }

  /// Function creates a peer connection
  /// [RTCPeerConnection] is used to create the connection object and return it.
  /// On creation the connection will send ice candidate information to the signalling
  /// server which then the server will pass them onto the [to] id which is the remote peer.
  /// [id] peer_id
  /// [media] is media type. Voice, data or video
  /// [userScreen] to be added but it would enable a user share screens
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
    return pc;
  } //End peer connection

  /// Function to create a offer to a peer using [RTCSessionDescription]
  /// The function will check what [media] type is passed and that will determine
  /// what constrains to use. Either [_voiceConstraints] or [_constraints].
  /// A local description is set and then the offer is sent onto the remote peer with the
  /// description information.
  /// [id] peer id
  /// [pc] peer connection
  /// [media] media type
  _createOffer(String id, RTCPeerConnection pc, String media) async {
    try {
      RTCSessionDescription s = await pc
          .createOffer(media == 'voice' ? _voiceConstraints : _constraints);

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

  /// Function that creates a session and send an answer event to the remote peer
  /// The function will check what [media] type is passed and that will determine
  /// what constrains to use. Either [_voiceConstraints] or [_constraints].
  /// A local description is set and them the offer is sent onto the remote peer.
  /// [id] peer id
  /// [pc] peer connection
  /// [media] media type
  _createAnswer(String id, RTCPeerConnection pc, media) async {
    try {
      // Create a session
      RTCSessionDescription s = await pc
          .createAnswer(media == 'voice' ? _voiceConstraints : _constraints);
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

  /// Function is used to send a bye event to the signalling server
  /// The server will then forward to the remote peer and replay it to the local user.
  /// [_sessionId] is made up from the local and remote peer id.
  void bye() {
    _send('bye', {
      'session_id': this._sessionId,
      'from': this._selfId,
    });
  }

  /// Function is used to create a JSON object from the map of data that
  /// is passed onto the [_socket] to send to the signalling server.
  /// [event] event type i.e 'new', 'answer' etc..
  /// [data] data to go with that type, like ids and session descriptions.
  _send(event, data) {
    var request = new Map();
    request["type"] = event; // Event type
    request["data"] = data; // Data with event type
    _socket.send(encoder.convert(request));
  } //End function
} //End class
