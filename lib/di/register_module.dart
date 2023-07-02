import 'package:app_chat_firebase/di/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:app_chat_firebase/firebase_options/firebase_options.dart' as firebase_dev;
import 'dependency_names.dart';

@module
abstract class RegisterModule {
  // Server url
  @dev
  @Named(DependencyNames.serverUrl)
  String get serverUrlDev => '';

  @stag
  @Named(DependencyNames.serverUrl)
  String get serverUrlStag => '';

  @prod
  @Named(DependencyNames.serverUrl)
  String get serverUrlProd => '';

  // Socket Url
  @dev
  @Named(DependencyNames.socketUrl)
  String get socketUrlDev => '';

  @stag
  @Named(DependencyNames.socketUrl)
  String get socketUrlStag => '';

  @prod
  @Named(DependencyNames.socketUrl)
  String get socketUrlProd => '';

  // Web Url
  @dev
  @Named(DependencyNames.webUrl)
  String get webUrlDev => '';

  @stag
  @Named(DependencyNames.webUrl)
  String get webUrlStag => '';

  @prod
  @Named(DependencyNames.webUrl)
  String get webUrlProd => '';

  // Should show log
  @dev
  @Named(DependencyNames.showLog)
  bool get showLogDev => true;

  @stag
  @Named(DependencyNames.showLog)
  bool get showLogStag => true;

  @prod
  @Named(DependencyNames.showLog)
  bool get showLogProd => false;

  // Android Package Name
  @dev
  @stag
  @Named(DependencyNames.androidPackageName)
  String get androidPackageNameTest => '';

  @prod
  @Named(DependencyNames.androidPackageName)
  String get androidPackageNameProd => '';

  // IOS Bundle Identifier
  @dev
  @stag
  @Named(DependencyNames.iosBundleIdentifier)
  String get iosBundleIdentifierTest => '';

  @prod
  @Named(DependencyNames.iosBundleIdentifier)
  String get iosBundleIdentifierProd => '';

  // App Store ID
  @dev
  @stag
  @Named(DependencyNames.iosAppStoreId)
  String get iosAppStoreIdTest => '';

  @prod
  @Named(DependencyNames.iosAppStoreId)
  String get iosAppStoreIdProd => '';

  // Firebase Option
  @dev
  @stag
  FirebaseOptions get firebaseOptionTest => firebase_dev.DefaultFirebaseOptions.currentPlatform;

  @prod
  FirebaseOptions get firebaseOptionProd => firebase_dev.DefaultFirebaseOptions.currentPlatform;
}
