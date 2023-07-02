import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/widgets/popups.dart';
import 'package:flutter/material.dart';
import 'package:app_chat_firebase/features/blocs/auth/auth_bloc.dart';
import 'package:flutter/services.dart';

import 'features/notifications/notifications_receiver.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  AppAutoRoute get appRouter => Get.find<AppAutoRoute>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _signedInData = Get.find<UserSecureStorage>().signedInData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
                  child: NotificationsReceiver(
                      appAutoRoute: widget.appRouter,
                      child: DismissKeyboard(child: childBody ?? Gaps.divider)),
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
                widget.appRouter,
                initialRoutes: [_initialRoutes() ?? SignInRoute()],
                navigatorObservers: () => [AutoRouteObserver()],
              ),
              routeInformationParser: widget.appRouter.defaultRouteParser(),
            ),
          ),
        );
      }
    );
  }

  void _onAuthError(String errorMessage) {
    final context = Get.find<GlobalKey<NavigatorState>>().currentContext;
    if (context == null) {
      return;
    }
    context.showErrorPopup(msg: errorMessage);
  }

  PageRouteInfo? _initialRoutes() =>
      _signedInData?.uid != null ? const HomeRoute() : SignInRoute() as PageRouteInfo;

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
