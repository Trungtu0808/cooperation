import 'package:app_chat_firebase/dependencies.dart';
import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  Bloc.observer =const AppBlocObserver()
    ..initial(
      () async {
         runApp(
          MyApp(
            appRoute: Get.find<AppAutoRoute>(),
          ),
        );
      },
    );
}
