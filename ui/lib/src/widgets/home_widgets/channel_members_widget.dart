import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';
import 'package:vertex_ui/src/pages/base_view.dart';
import 'package:vertex_ui/src/providers/channel_members_view_model.dart';
import 'package:vertex_ui/src/widgets/api_exception_alert_dialog.dart';
import 'package:vertex_ui/src/widgets/exception_alert_dialog.dart';

/// This class is used for building an [AlertDialog] UI element that will display
/// information of [User]s in a [Channel] received from the database with the
/// help of the [ChannelMembersViewModel] class. [buildBaseView] takes advantage
/// of this class

class ChannelMembersWidget extends StatefulWidget {
  final Channel channel;

  const ChannelMembersWidget({Key key, @required this.channel});

  @override
  _ChannelMembersWidgetState createState() =>
      _ChannelMembersWidgetState(channel: channel);
}

class _ChannelMembersWidgetState extends State<ChannelMembersWidget> {
  final Channel channel;

  _ChannelMembersWidgetState({Key key, this.channel});

  @override
  Widget build(BuildContext context) {
    return buildBaseView(context);
  }

  /// This [Widget] uses the [BaseView] class which converts this [StatelessWidget]
  /// into a [StatefulWidget] so it can pass a Function(t) that returns a model.
  /// In this class the [ChannelMembersViewModel] is needed as this widget builds a list of
  /// channel members from that data received from [ChannelMembersViewModel.getChannelMembers].
  ///
  /// Should an exceptions be throw during the [ChannelMembersViewModel.getChannelMembers] the error
  /// is caught and a [AlertDialog] is displayed to the user informing them of an
  /// exception.
  ///
  /// The [BaseView.onModelReady] is super useful as now the UI element can know
  /// if it can display a progress indicator or the data depending on the [BaseModel.state].
  BaseView<ChannelMembersViewModel> buildBaseView(BuildContext context) {
    return BaseView<ChannelMembersViewModel>(
      onModelReady: (model) =>
          model.getChannelMembers(channel.id).catchError((onError) {
        showDialog(
            context: context,
            builder: (BuildContext content) => onError == ApiException
                ? ApiExceptionAlertDialog(apiException: onError)
                : ExceptionAlertDialog(exception: onError));
      }), //Get channels
      builder: (context, model, child) {
        return model.state == ViewState.Idle
            ? _customDialog(context, model.channelMembers)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /// Widget creates a custom [AlertDialog] to display the list of
  /// [User]s / members in a [Channel]
  Widget _customDialog(context, membersList) {
    return AlertDialog(
      title: Text("Channel Member"),
      content: _channelMembersListView(membersList),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext content) => _addMemberDialog(context)),
            child: Text("Add Member"))
      ],
    );
  }

  Widget _addMemberDialog(context) {
    return AlertDialog(
      title: Text("Select a user to add"),
      content: _usersListView(),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _usersListView() {
    List<User> _userList =
        locatorGlobal<ChannelMembersViewModel>().allUsersList;

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        height: 300.0,
        width: 300.0,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: _userList.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: _listListTitle(_userList[index], true),
                  ),
                ),
              );
            }),
      ),
    ]);
  }

  /// Widget Builds a list of Cards with information about members /[User]s of a [Channel].
  Widget _channelMembersListView(membersList) {
    print(membersList);
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        height: 300.0,
        width: 300.0,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: membersList.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: _listListTitle(membersList[index], false),
                  ),
                ),
              );
            }),
      ),
    ]);
  }

  Widget _listListTitle(listData, bool add) {
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
          listData.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        //TODO - CB - Review this,
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
        trailing: add
            ? IconButton(
                onPressed: () => addUserToChannel(channel.id, listData),
                hoverColor: Colors.lightGreenAccent,
                icon: Icon(FontAwesomeIcons.userPlus,
                    color: Colors.white, size: 20.0))
            : IconButton(
                onPressed: () => removeUser(channel.id, listData.id),
                hoverColor: Colors.red,
                icon: Icon(FontAwesomeIcons.userSlash,
                    color: Colors.white, size: 20.0)));
  }

  /// Function makes a add request to the [ChannelMembersViewModel]
  /// where that will handle making the HTTP reset and update the
  /// state of the Listens
  void addUserToChannel(int channelId, User user) {
    locatorGlobal<ChannelMembersViewModel>()
        .addMember(channelId, user)
        .catchError((onError) => showDialog(
            context: context,
            builder:  (BuildContext content) =>
                ApiExceptionAlertDialog(
              apiException: onError,
            )));
  }

  /// Function makes a remove request to the [ChannelMembersViewModel]
  /// where that will handle making the HTTP reset and update the
  /// state of the Listens
  void removeUser(int channelId, int userId) {
    locatorGlobal<ChannelMembersViewModel>()
        .removeMember(channelId, userId)
        .catchError((onError) => showDialog(
            context: context,
            builder:  (BuildContext content) =>
                ApiExceptionAlertDialog(
              apiException: onError,
            )));
  } //End removeUser
} //End class
