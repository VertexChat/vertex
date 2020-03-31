import 'package:get_it/get_it.dart';
import 'package:vertex_ui/src/providers/channels_view_model.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

/// This class registers services into the application on startup
/// https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
/// https://pub.dev/packages/get_it

GetIt locatorGlobal = GetIt.instance;

//TODO - This may be messy, need to check this out more
void setupLocator() {
  //Register Navigation Services
  locatorGlobal.registerLazySingleton(() => NavigationService());
  locatorGlobal.registerLazySingleton(() => NavigationServiceHome());
  // Register Provider State Management Services
  locatorGlobal.registerFactory(() => ChannelsViewModel());
}//End
