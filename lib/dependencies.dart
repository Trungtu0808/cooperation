import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/cupertino.dart';

Future<void> setupAppDependencies()async{
  logger.i('SERVICE starting...');

  Get.put(GlobalKey<NavigatorState>());
  Get.put<AppAutoRoute>(AppAutoRoute(Get.find<GlobalKey<NavigatorState>>()), permanent: true);
}