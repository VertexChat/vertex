import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/home/home_page.dart';
import 'package:vertex_ui/src/pages/layout_template/landing_page.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/pages/settings/settings_page.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/pages/voice_channel/voice_call.dart';
import 'package:vertex_ui/src/routing/route_names.dart';
import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

/// Switch statement that is used to return the page a user is trying to navigate to
/// Global Routes
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(VertexHomePage(), settings);
    case SettingsRoute:
      return _getPageRoute(SettingsPage(), settings);
    case LoginRoute:
      return _getPageRoute(LoginPage(), settings);
    case RegisterRoute:
      return _getPageRoute(RegisterPage(), settings);
    default:
      return _getPageRoute(VertexHomePage(), settings);
  } //End switch
} //End function

/// Switch statement for internal routes.
/// This is needed as users cannot just route to theses pages
/// TODO: CB - Document this and explain design choices on why
Route<dynamic> internalRoutes(RouteSettings settings) {
  switch (settings.name) {
    case MessageRoute:
      Channel channel = settings.arguments;
      return _getPageRoute(TextChatScreen(channel: channel), settings);
    case VoiceChannelRoute:
      Channel channel = settings.arguments;
      return _getPageRoute(VoiceCall(channel: channel), settings);
    case LandingPageRoute:
      return _getPageRoute(LandingPage(), settings);
    default:
      return _getPageRoute(LandingPage(), settings);
  } //End switch
} //End function

/// Returns a page which is a [Widget] and [RouteSettings]
PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
} //End function

//TODO: Try implemented a different animation when switching pages
