import 'dart:ui';

import 'package:app_chat_firebase/import_file/import_all.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  void initial(Function init){
    try{
      init();
      // runZonedGuarded(
      //       () => init(),
      //       (error, stack) => _onError(error, stack),
      // );
    }catch(e){
      logger.e(e);
    }
  }
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  Future<void> _onError(Object error, StackTrace stack) async {
    try {
      //if (FirebaseC)
      logger.e('error main app $error');
    } catch (e) {
      logger.e('error main app $e');
    }
  }
}
