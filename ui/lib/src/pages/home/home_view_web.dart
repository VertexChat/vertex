import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/widgets/app_navigation_bar.dart';
import 'package:vertex_ui/src/widgets/server_app_drawer/server_drawer.dart';

import '../text_chat_page.dart';

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      //App drawer
      ServerDrawer(),
      Expanded(
          child: Container(
              constraints: BoxConstraints.expand(), child: TextChatScreen())),
    ];

    return Scaffold(
      appBar: AppNavigationBar(), // Top app bar
      body: Row(children: children),
    );
  } //End builder
} //End class
