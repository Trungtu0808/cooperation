import 'package:app_chat_firebase/build_configs.dart';
import 'package:app_chat_firebase/constants/app_constant.dart';
import 'package:flutter/services.dart';

abstract class AppMethodChannel {
  static const _platform = MethodChannel(AppConstant.appMethodChannel);

  static Future<BuildConfigs> getBuildConfig() async {
    final result = await _platform.invokeMethod(AppConstant.getBuildConfigs) as Map;
    final flavorValue = result['flavor'] as String;
    final flavor = Flavor.fromString(flavorValue);
    if (flavor == null) {
      throw Exception('$flavorValue not supported');
    }
    return BuildConfigs(
      appId: result['appId'] as String,
      flavor: flavor,
    );
  }
}
