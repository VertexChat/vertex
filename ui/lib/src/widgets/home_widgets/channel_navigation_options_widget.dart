import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vertex_ui/locator.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

/// Class that builds and returns a custom navigation [Widget]
/// [@required] [Channel] object
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
        // Button to navigate to edit channel page
        IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () => locatorGlobal<NavigationServiceHome>()
                .navigateTo(EditChannelRoute, arguments: channel)),
        SizedBox(width: 25),
        // Button to navigate to landing page
        IconButton(
            icon: Icon(FontAwesomeIcons.home),
            onPressed: () => locatorGlobal<NavigationServiceHome>()
                .navigateTo(LandingPageRoute)),
      ],
    );
  } //End builder
} //End class
