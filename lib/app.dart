import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/widgets/popups.dart';
import 'package:flutter/material.dart';
import 'package:app_chat_firebase/features/blocs/auth/auth_bloc.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  final AppAutoRoute appRoute;

  const MyApp({super.key, required this.appRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _signedInData = Get.find<UserSecureStorage>().signedInData;
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
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (context) => AuthBloc(
                            userSecureStorage: Get.find<UserSecureStorage>(),
                            onAuthError: _onAuthError,
                          )..add(AuthFirstLoadUserEvent())),
                    ],
                    child: DismissKeyboard(child: childBody ?? Gaps.divider),
                  );
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
                  initialRoutes: [_initialRoutes() ?? SignInRoute()],
                  navigatorObservers: () => [AutoRouteObserver()],
                ),
                routeInformationParser: widget.appRoute.defaultRouteParser(),
              ),
            ),
          );
        }));
  }
  void _onAuthError(String errorMessage){
    final context = Get.find<GlobalKey<NavigatorState>>().currentContext;
    if (context == null){
      return;
    }
    context.showErrorPopup(msg: errorMessage);
  }

  PageRouteInfo? _initialRoutes() => _signedInData?.uid != null ? const HomeRoute() :
        SignInRoute() as PageRouteInfo;
}