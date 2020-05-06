import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:vertex_ui/src/enums/signaling_state_enum.dart';
import 'package:vertex_ui/src/services/signaling.dart';

class VideoCallPage extends StatefulWidget {
  //Member Variables
  final String pageTitle;
  final String ip;

  // Constructor
  VideoCallPage({Key key, this.pageTitle, this.ip}) : super(key: key);

  @override
  _VideoCallPageState createState() =>
      _VideoCallPageState(serverIP: "vertex.chat");
} //End class

/// Stateless class
class _VideoCallPageState extends State<VideoCallPage> {
  // Variables
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool _isConnecting = false;
  bool _fetchingData = false;
  bool _connection = false;
  bool _inCalling = false;
  Signaling _signaling;
  final String serverIP;
  List<dynamic> _peers;
  var _selfId;

  // Constructors
  _VideoCallPageState({Key key, @required this.serverIP});

  /// [initRenderers] and [_connect] on init of [Widget]
  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
  }

  /// Function init local and remote renders
  /// mainly needed for android and iOS platforms
  initRenderers() async {
    // Init local & remote Renders
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  /// Connects to the signalling server using [Signaling] to handle to
  /// web socket events like open, message and close.
  /// The [SignalingState] is updated depending on events that take place
  /// in the [Signaling] class this then logs or updates the application
  /// state.
  void _connect() async {
    if (_signaling == null) {
      // Connect with ip provided
      _signaling = new Signaling(serverIP)..connect();
      // Handle state changes wih signalling:
      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            // Update state to display in call UI with video elements:
            this.setState(() => _inCalling = true);
            break;
          case SignalingState.CallStateBye:
            // Update state to remove video elements
            this.setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _inCalling = false;
            });
            break;
          case SignalingState.FetchingData:
            this.setState(() => _fetchingData = true);
            break;
          case SignalingState.ReceivedData:
            this.setState(() => _fetchingData = false);
            break;
          case SignalingState.CallStateInvite:
            print(SignalingState.CallStateInvite);
            break;
          case SignalingState.CallStateConnected:
            this.setState(() => _connection = true);
            break;
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
            this.setState(() => _connection = false);
            break;
          case SignalingState.ConnectionConnecting:
            this.setState(() => _isConnecting = true);
            break;
          case SignalingState.ConnectionOpen:
            this.setState(() => _connection = true);
            break;
        } //End switch
      }; //End onStateChange

      // Update state for peers
      _signaling.onPeersUpdate = ((event) {
        this.setState(() {
          _selfId = event['self'];
          _peers = event['peers'];
        });
      });

      // Set local stream
      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      // Set remote stream
      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      // Remove remote stream
      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    } //ENd if
  } //End connect function

  /// Function creates a invite to talk with a peer that is listed in the UI
  /// Call is handles by the [_signaling] class which will send it onto the
  /// signalling server.
  /// [peerId] the id of the peer displayed
  /// [useScreen] screen sharing - TODO
  _invitePeer(peerId, useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', useScreen);
    }
  } //End function

  /// Function to hang up an active call. A bye event is sent to the server
  /// which forwards its onto the remote peer and replays it to the local peer
  /// closing all connections.
  _hangUp() {
    if (_signaling != null) {
      _signaling.bye();
    }
  }

  /// Function to change change
  _switchCamera() {
    _signaling.switchCamera();
  }

  /// Function to mute local mic
  _muteMic(bool mute) {
    _signaling.muteMic(mute);
  }

  /// [Widget] that builds a list of peers from the data received from the server
  /// including one element which display load peer information.
  /// [peer] peer data
  Widget _buildRow(peer) {
    // local users id
    var self = (peer['id'] == _selfId);
    return ListBody(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8.0,
          child: ListTile(
            title: Text(
                self
                    ? peer['username'] + ' - You. User ID: ' + peer['id']
                    : peer['username'],
                style: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            onTap: () => self ? null : _invitePeer(peer['id'], false),
            trailing: new SizedBox(
                width: 50.0,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      self
                          ? Container()
                          : IconButton(
                              icon: const Icon(Icons.phone),
                              //Invite id to audio call;
                              onPressed: () => _invitePeer(peer['id'], false),
                              // TODO
                              tooltip: 'Voice Call',
                            )
                    ])),
            subtitle: Text('User ID: ' + peer['id']),
          ),
        ),
      ),
    ]);
  } //End buildRow

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connect to a video call'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _inCalling
            ? SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FloatingActionButton(
                          child: const Icon(Icons.switch_camera),
                          onPressed: _switchCamera,
                        ),
                        FloatingActionButton(
                          onPressed: _hangUp,
                          tooltip: 'Hangup',
                          child: new Icon(Icons.call_end),
                          backgroundColor: Colors.pink,
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.mic_off),
                          onPressed: _muteMic(true),
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.mic),
                          onPressed: _muteMic(false),
                        )
                      ]),
                ))
            : null,
        body: _inCalling
            ? OrientationBuilder(builder: (context, orientation) {
                return new Container(
                  child: new Stack(children: <Widget>[
                    new Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                        child: new Container(
                          margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: new RTCVideoView(_remoteRenderer),
                          decoration: new BoxDecoration(color: Colors.black54),
                        )),
                    new Positioned(
                      left: 20.0,
                      top: 20.0,
                      child: new Container(
                        width:
                            orientation == Orientation.portrait ? 90.0 : 120.0,
                        height:
                            orientation == Orientation.portrait ? 120.0 : 90.0,
                        child: new RTCVideoView(_localRenderer),
                        decoration: new BoxDecoration(color: Colors.black54),
                      ),
                    ),
                  ]),
                );
              })
            : _fetchingData
                ? Center(child: CircularProgressIndicator())
                : _connection
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        itemCount: (_peers != null ? _peers.length : 0),
                        itemBuilder: (context, i) {
                          return _buildRow(_peers[i]);
                        })
                    : Center(
                        child: Text(
                            "Unable to connect to server. Please refresh to try again or contact support"),
                      ));
  } //end Widget build
} //End class
