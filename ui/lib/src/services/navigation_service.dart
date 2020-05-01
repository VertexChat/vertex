import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// This class is used to allow for the use of navigation without a context in flutter
/// A GlobalKey is registered to use for the navigatorKey, this key is used to route
/// to different pages in the application
///
// https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/

/// These classes are registered as a service in locator.dart. [GetIt] package
/// handles the register of the services

/// This class handles the generated routes that can be accessed via url route name
class NavigationService {
  /// A key that is unique across the entire app.
  ///
  /// Global keys uniquely identify elements. Global keys provide access to other
  /// objects that are associated with those elements, such as [BuildContext].
  /// For [StatefulWidget]s, global keys also provide access to [State].
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigates to a page by [routeName
  Future<dynamic> navigateTo(String routeName) async {
    return await navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (_) => false);
  }
} //End class

/// This class handles the internal navigation via button presses. Users
/// can not just route to these routes
class NavigationServiceHome {
  /// A key that is unique across the entire app.
  ///
  /// Global keys uniquely identify elements. Global keys provide access to other
  /// objects that are associated with those elements, such as [BuildContext].
  /// For [StatefulWidget]s, global keys also provide access to [State].
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigates to a page by [routeName] and can take dynamic [arguments]
  /// These arguments are used to pass data from one page to another
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return await navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
  }
} //End class
