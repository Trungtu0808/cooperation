import 'package:app_chat_firebase/dependencies.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: ContantsFireBase.apiKey,
            appId: ContantsFireBase.appId,
            messagingSenderId: ContantsFireBase.messagingSenderId,
            projectId: ContantsFireBase.projectId));
  } else {
    await Firebase.initializeApp(
      name: 'app-chat', //AppConfig.appName,
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await setupAppDependencies();
  Bloc.observer = AppBlocObserver(
    () => runApp(
      MyApp(
        appRoute: Get.find<AppAutoRoute>(),
      ),
    ),
  )..initial();
}

class MyApp extends StatefulWidget {
  final AppAutoRoute appRoute;

  const MyApp({super.key, required this.appRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [AppConstant.defaultLocale, Locale('vi', 'Vn')],
        fallbackLocale: AppConstant.defaultLocale,
        child: Builder(builder: (context) {
          return AnnotatedRegion(
            value: SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Theme.of(context).canvasColor,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            //Provider support for overlay, make it easy to build TOAST and IN-APP notification
            child: OverlaySupport.global(
              child: MaterialApp.router(
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                title: AppConfig.appName,
                debugShowCheckedModeBanner: false,
                builder: (context, childBody) {
                 return childBody ?? Gaps.divider;
                  // final mediaQueryData = MediaQuery.of(context);
                  // final textScaleFactor = mediaQueryData.textScaleFactor.clamp(1.0, 1.1);
                  // return MediaQuery(
                  //     data: mediaQueryData.copyWith(textScaleFactor: textScaleFactor),
                  //     child: childBody ?? Gaps.divider);
                },
                themeMode: ThemeMode.light,
                theme: AppTheme.getTheme(isDark: false),
                darkTheme: AppTheme.getTheme(isDark: true),
                routerDelegate: AutoRouterDelegate(
                  widget.appRoute,
                  initialRoutes: [SignRoute()],
                  navigatorObservers: () => [AutoRouteObserver()],
                ),
                routeInformationParser: widget.appRoute.defaultRouteParser(),
              ),
            ),
          );
        }));
  }
}
