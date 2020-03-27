import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:vertex_ui/src/pages/video_call/signaling.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_nane_widget.dart';
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
  final Channel channel;
  Signaling _signaling;
  List<dynamic> _peers;
  var _selfId;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool _inCalling = false;
  final String serverIP = "18.203.171.99"; //Hardcoded for now

  //Constructor
  _VoiceCallState({Key key, this.channel});

  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
  }

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

  void _connect() async {
    if (_signaling == null) {
      // Connect with ip provided
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
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
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

  _invitePeer(context, peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', use_screen);
    }
  } //End function

  // Build List view of peers
  _buildRow(context, peer) {
    // Local user ID - Randomly Generated
    var self = (peer['id'] == _selfId);

    return ListBody(children: <Widget>[
      ListTile(
        title: Text(self
            ? peer['name'] + '[Your self]'
            : peer['name'] + '[' + peer['user_agent'] + ']'),
        onTap: null,
        trailing: new SizedBox(
            width: 100.0,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.phone),
                    //Invite id to audio call;
                    onPressed: () => _invitePeer(context, peer['id'], false),
                    tooltip: 'Voice Call',
                  ),
                ])),
        subtitle: Text('id: ' + peer['id']),
      ),
      Divider()
    ]);
  } //End buildRow

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
              ChannelNavigationOptionsWidget(channel: channel),
            ],
          ),
          Expanded(
            child: Container(
              child: new ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: (_peers != null ? _peers.length : 0),
                  itemBuilder: (context, i) {
                    return _buildRow(context, _peers[i]);
                  }),
            ),
          ),
        ],
      ),
    );
  } //End builder
}
