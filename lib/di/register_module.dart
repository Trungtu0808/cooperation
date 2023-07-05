import 'package:app_chat_firebase/di/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:app_chat_firebase/firebase_options/firebase_options_dev.dart' as firebase_dev;
import 'package:app_chat_firebase/firebase_options/firebase_options_stag.dart' as firebase_stag;
import 'package:app_chat_firebase/firebase_options/firebase_options.dart' as firebase_prod;

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
  @Named(DependencyNames.androidPackageName)
  String get androidPackageNameDev => '';

  @stag
  @Named(DependencyNames.androidPackageName)
  String get androidPackageNameStag => '';

  @prod
  @Named(DependencyNames.androidPackageName)
  String get androidPackageNameProd => '';

  // IOS Bundle Identifier
  @dev
  @Named(DependencyNames.iosBundleIdentifier)
  String get iosBundleIdentifierDev => '';

  @stag
  @Named(DependencyNames.iosBundleIdentifier)
  String get iosBundleIdentifierStag => '';

  @prod
  @Named(DependencyNames.iosBundleIdentifier)
  String get iosBundleIdentifierProd => '';

  // App Store ID
  @dev
  @Named(DependencyNames.iosAppStoreId)
  String get iosAppStoreIdDev => '';

  @stag
  @Named(DependencyNames.iosAppStoreId)
  String get iosAppStoreIdStag => '';

  @prod
  @Named(DependencyNames.iosAppStoreId)
  String get iosAppStoreIdProd => '';

  // Firebase Option
  @dev
  FirebaseOptions get firebaseOptionDev => firebase_dev.DefaultFirebaseOptions.currentPlatform;

  @stag
  FirebaseOptions get firebaseOptionStag => firebase_stag.DefaultFirebaseOptions.currentPlatform;

  @prod
  FirebaseOptions get firebaseOptionProd => firebase_prod.DefaultFirebaseOptions.currentPlatform;
}
