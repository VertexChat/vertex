import 'package:get_it/get_it.dart';
import 'package:vertex_ui/src/services/navigation_service.dart';

/// https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
///
GetIt locatorGlobal = GetIt.instance;
GetIt locatorHome = GetIt.instance;

//TODO - This may be messy, need to check this out more
void setupLocator() {
  locatorGlobal.registerLazySingleton(() => NavigationService());
  locatorHome.registerLazySingleton(() => NavigationServiceHome());
}