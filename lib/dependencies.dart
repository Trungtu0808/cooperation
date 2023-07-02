import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupAppDependencies()async{
  logger.i('SERVICE starting...');

  await _appService();
  await _appDataProvider();
  Get.put(GlobalKey<NavigatorState>());
  Get.put<AppAutoRoute>(AppAutoRoute(Get.find<GlobalKey<NavigatorState>>()), permanent: true);

}

Future<void> _appService() async{
  // Easy Localization
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  
  // Hive
  var appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  await Hive.openBox(AppConstant.keyBoxSetting);
  Hive.registerAdapter(AppConfigModelAdapter());

  //Firebase
  // await Firebase.initializeApp(
  //   options: DI.provide<FirebaseOptions>(),
  // );
  await Firebase.initializeApp();

}

Future<void> _appDataProvider()async{

  var userSecureStorage = UserSecureStorage();
  await userSecureStorage.init();

  // local storage
  Get.put<UserSecureStorage>(userSecureStorage, permanent: true);
  Get.put<LocalNotificationService>(LocalNotificationService(), permanent: true);
  //Get.put<FirebaseNotificationService>(FirebaseNotificationService.instance, permanent: true);

  // data repo
  Get.lazyPut<FireBaseAuthRepo>(() => FireBaseAuthRepo(), fenix: true);
  Get.lazyPut<AuthRepo>(() => AuthRepo(), fenix: true);
  Get.lazyPut<DeviceRepo>(() => DeviceRepo(), fenix: true);

  //service
  Get.lazyPut<AuthServices>(() => AuthServices(), fenix: true);
}