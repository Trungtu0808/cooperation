import 'package:app_chat_firebase/core/dio/dio_module.dart';
import 'package:app_chat_firebase/data/device/device_repo.dart';
import 'package:app_chat_firebase/di/dependency_names.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupAppDependencies() async {
  logger.i('SERVICE starting...');

  await _appService();
  await _appDataProvider();
  Get.put(GlobalKey<NavigatorState>());
  Get.put<AppAutoRoute>(AppAutoRoute(Get.find<GlobalKey<NavigatorState>>()), permanent: true);
}

Future<void> _appService() async {
  // Easy Localization
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  // Hive
  var appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  await Hive.openBox(AppConstant.keyBoxSetting);
  Hive.registerAdapter(AppConfigModelAdapter());

  // Firebase
  await Firebase.initializeApp(
    name: 'app-chat',
    options: DI.provide<FirebaseOptions>(),
  );

  //FlutterError.onError = (details) async {
    // Call crash test
    // FirebaseCrashlytics.instance.crash();

    // if (kDebugMode) {
    //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // } else {
    //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    //   FirebaseCrashlytics.instance.sendUnsentReports();
    // }
    // FirebaseCrashlytics.instance.recordFlutterFatalError(details);

    //log(details.exceptionAsString(), stackTrace: details.stack);
 // };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
}

Future<void> _appDataProvider() async {
  var userSecureStorage = UserSecureStorage();
  await userSecureStorage.init();

  getIt.registerSingleton<DioModule>(DioModule(
    baseUrl: DI.provide<String>(instanceName: DependencyNames.serverUrl),
    showLog: DI.provide<bool>(instanceName: DependencyNames.showLog),
    userSecureStorage: getIt.registerSingleton<UserSecureStorage>(UserSecureStorage()),
  ));

  // // local storage
  Get.put<UserSecureStorage>(userSecureStorage, permanent: true);
  Get.put<LocalNotificationService>(LocalNotificationService(), permanent: true);
  Get.put<FirebaseNotificationService>(FirebaseNotificationService.instance, permanent: true);
  //
  // // data repo
  Get.lazyPut<FireBaseAuthRepo>(() => FireBaseAuthRepo(), fenix: true);
  Get.lazyPut<AuthRepo>(() => AuthRepo(), fenix: true);
  Get.lazyPut<DeviceRepo>(() => DeviceRepo(), fenix: true);
  //
  // //service
  Get.lazyPut<AuthServices>(() => AuthServices(), fenix: true);
}
