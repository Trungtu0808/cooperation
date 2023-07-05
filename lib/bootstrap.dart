import 'package:app_chat_firebase/build_configs.dart';
import 'package:flutter/material.dart';
import 'app_method_channel.dart';
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
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  buildConfigs = await AppMethodChannel.getBuildConfig();
  final env = DI.environmentFromFlavor(buildConfigs.flavor);
  await initDI(env);
  await setupAppDependencies();

  Bloc.observer = AppBlocObserver();
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

}


