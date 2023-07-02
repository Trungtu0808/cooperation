import 'dart:developer';
import 'package:app_chat_firebase/build_configs.dart';
import 'package:flutter/material.dart';
import 'dependencies.dart';
import 'import_file/import_all.dart';

late final BuildConfigs buildConfigs;

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    _onError(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {

  // buildConfigs = await AppMethodChannel.getBuildConfig();
  // final env = DI.environmentFromFlavor(buildConfigs.flavor);
  // await initDI(env);


  // Bloc.observer = AppBlocObserver();
  // runZonedGuarded(
  //       () async {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await EasyLocalization.ensureInitialized();
  //
  //     await setupAppDependencies();
  //
  //     runApp(
  //       EasyLocalization(
  //         supportedLocales: const [
  //           AppLocale.enLocale,
  //           AppLocale.viLocale,
  //         ],
  //         path: 'assets/translations',
  //         fallbackLocale: AppLocale.defaultLocale,
  //         // assetLoader: CodegenLoader(),
  //         child: await builder(),
  //       ),
  //     );
  //     FlutterError.onError = (details) {
  //       log(details.exceptionAsString(), stackTrace: details.stack);
  //     };
  //   },
  //   _onError,
  // );

  // Bloc.observer = AppBlocObserver();
  // runApp(
  //   EasyLocalization(
  //     supportedLocales: const [
  //       AppLocale.enLocale,
  //       AppLocale.viLocale,
  //     ],
  //     path: 'assets/translations',
  //     fallbackLocale: AppLocale.defaultLocale,
  //     // assetLoader: CodegenLoader(),
  //     child: await builder(),
  //   ),
  // );
  // Bloc.observer = AppBlocObserver();
  BlocOverrides.runZoned(() async{
    await runZonedGuarded(
            () async {
          WidgetsFlutterBinding.ensureInitialized();

          await setupAppDependencies();
          runApp(
            EasyLocalization(
              supportedLocales: const [
                AppLocale.enLocale,
                AppLocale.viLocale,
              ],
              path: 'assets/translations',
              fallbackLocale: AppLocale.defaultLocale,
              // assetLoader: CodegenLoader(),
              child: await builder(),
            ),
          );
          FlutterError.onError = (details) {
            log(details.exceptionAsString(), stackTrace: details.stack);
          };
        },
        _onError,
    );
  });

}

Future<void> _onError(Object error, StackTrace stack) async {
  logger.e('Application', error, stack);
  try {
    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
      await FirebaseCrashlytics.instance.recordError(error, stack);
    }
  } catch (e) {
    logger.e(e);
  }
}

