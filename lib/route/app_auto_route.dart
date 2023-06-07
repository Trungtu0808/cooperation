import 'package:auto_route/auto_route.dart';
import 'package:app_chat_firebase/features/screens/screens_import.dart';
part 'general_auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Dialog,Route',
  routes: <AutoRoute>[
    loginPage,
    homePage,
  ],
)
class $AppAutoRoute {}
//class AppAutoRoute extends _$AppAutoRoute {}
