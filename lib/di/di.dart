import 'package:app_chat_firebase/dependencies.dart';
import 'package:app_chat_firebase/build_configs.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:app_chat_firebase/di/di.config.dart';

const stag = Environment('stag');

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
)

Future initDI(Environment environment) async{
  getIt.$initGetIt(environment: environment.name);
  await getIt.allReady();
}
abstract class DI {
  static final _getIt = getIt;
  static GetIt get getItDI => _getIt;

  static T provide<T extends Object>({String? instanceName}) => getItDI.get<T>(
        instanceName: instanceName,
      );

  static Environment environmentFromFlavor(Flavor flavor) {
    switch (flavor) {
      case Flavor.prod:
        return prod;
      case Flavor.dev:
        return dev;
      case Flavor.stag:
        return stag;
    }
  }
}
