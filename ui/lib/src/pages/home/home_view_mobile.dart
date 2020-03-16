import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/text_chat_page.dart';
import 'package:vertex_ui/src/widgets/main_app_widgets/app_navigation_bar.dart';
import 'package:vertex_ui/src/widgets/server_app_drawer/server_drawer.dart';

class HomeMobilePortrait extends StatelessWidget {
  HomeMobilePortrait({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppNavigationBar(),
      drawer: ServerDrawer(),
      body: TextChatScreen(),
      //More widgets to add here
    );
  }
}
