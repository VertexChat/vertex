import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';
import 'package:vertex_ui/src/widgets/home_widgets/channel_members_widget.dart';

/// Class that builds and returns a custom navigation [Widget]
/// A [Channel] object is required for this widget.
/// [NavigationServiceHome] is used to allow for navigation between
/// [LandingPageRoute] & [EditChannelRoute]

class ChannelNavigationOptionsWidget extends StatelessWidget {
  const ChannelNavigationOptionsWidget({
    Key key,
    @required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: Icon(FontAwesomeIcons.userFriends),
            onPressed: () => showDialog(
                context: context,
                child: ChannelMembersWidget(channel: channel))),
        // Button to navigate to edit channel page
        SizedBox(width: 25),
        // Button to navigate to landing page
        IconButton(
            icon: Icon(FontAwesomeIcons.home),
            onPressed: () => locatorGlobal<NavigationServiceHome>()
                .navigateTo(LandingPageRoute)),
        SizedBox(width: 25),
        IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () => locatorGlobal<NavigationServiceHome>()
                .navigateTo(EditChannelRoute, arguments: channel)),
      ],
    );
  } //End builder
} //End class
