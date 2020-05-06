import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertex_ui/src/enums/signaling_state_enum.dart';
import 'package:vertex_ui/src/services/signaling.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_name_widget.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_navigation_options_widget.dart';

/// https://stackoverflow.com/questions/48481590/how-to-set-update-state-of-statefulwidget-from-other-statefulwidget-in-flutter
class VoiceCall extends StatefulWidget {
  final Channel channel;

  const VoiceCall({Key key, @required this.channel}) : super(key: key);

  @override
  _VoiceCallState createState() => _VoiceCallState(channel: channel);
} //End class

class _VoiceCallState extends State<VoiceCall> {
  //Member Variables
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  final String serverIP = "vertex.chat"; //Hardcoded for now
  SharedPreferences userDetails;
  Signaling _signaling;
  bool _fetchingData = false;
  bool _isConnecting = false;
  bool _inCalling = false;
  bool _connection = false;
  final Channel channel;
  List<dynamic> _peers = [];
  String _username = ' ';
  var _selfId;

  //Constructor
  _VoiceCallState({Key key, this.channel});

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
      _signaling = new Signaling(serverIP)..connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() => _inCalling = true);
            break;
          case SignalingState.CallStateBye:
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

  // Invite peer
  _invitePeer(context, peerId, useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'voice', useScreen);
    }
  } //End function

  _hangUp() {
    if (_signaling != null) {
      _signaling.bye();
    }
  }

  _muteMic(bool mute) {
    _signaling.muteMic(mute);
  }

  // Build List view of peers
  _buildRow(context, peer) {
    // Check if id match
    var self = (peer['id'] == _selfId);
    if (!self) {
      _username = peer['username'];
    }

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
            onTap: () => self ? null : _invitePeer(context, peer['id'], false),
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
                              onPressed: () =>
                                  _invitePeer(context, peer['id'], false),
                              // TODO
                              tooltip: 'Voice Call',
                            )
                    ])),
            subtitle: Text('Device Information ' + peer['device_name']),
          ),
        ),
      ),
    ]);
  } //End buildRow

  Widget _listListTitle() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(FontAwesomeIcons.user, color: Colors.white),
      ),
      title: Text(
        "In a call with: $_username",
        style: TextStyle(
            color: Colors.lightGreenAccent, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ChannelNameWidget(channel: channel),
              ChannelNavigationOptionsWidget(channel: channel, isVoiceChannel: true,),
            ],
          ),
          _inCalling
              ? OrientationBuilder(builder: (context, orientation) {
                  return Container(
                    child: Column(children: <Widget>[
                      Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black26),
                          child: Column(
                            children: <Widget>[
                              _listListTitle(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () => _muteMic(true),
                                            tooltip: 'Mute Mic',
                                            hoverColor: Colors.lightGreenAccent,
                                            icon: Icon(
                                              Icons.mic_off,
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => _muteMic(false),
                                            tooltip: 'umute mic',
                                            hoverColor: Colors.lightGreenAccent,
                                            icon: Icon(
                                              Icons.mic,
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => _hangUp(),
                                            tooltip: 'Hangup',
                                            hoverColor: Colors.red,
                                            icon: Icon(
                                              Icons.call_end,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Visibility(
                            visible: true, //Default is true,
                            child: Container(
                                width: 100,
                                height: 100,
                                child: new RTCVideoView(_localRenderer)),
                          ),
                          Visibility(
                            visible: true, //Default is true,
                            child: Container(
                                width: 100,
                                height: 100,
                                child: new RTCVideoView(_remoteRenderer)),
                          )
                        ],
                      )
                    ]),
                  );
                })
              : _fetchingData
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: Container(
                        child: _connection
                            ? ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0.0),
                                itemCount: (_peers != null ? _peers.length : 0),
                                itemBuilder: (context, i) {
                                  return _buildRow(context, _peers[i]);
                                })
                            : Center(
                                child: Text(
                                    "Unable to connect to server. Please refresh to try again or contact support"),
                              ),
                      ),
                    ),
        ],
      ),
    );
  } //End builder
}
