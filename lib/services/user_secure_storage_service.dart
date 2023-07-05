
import 'dart:convert';

import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_model/features/auth/resp/signed_in_data.dart';

typedef _ObjectGenerator<T> = T Function(Map<String, dynamic>);

class UserSecureStorage {
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    _box = await Hive.openBox(
      'secureStorage${AppConfig.appName}',
    );
    _signedInData = _getSignedInData();
    _isInitialized = true;
  }

  late Box _box;

  final _signedInDataKey = 'loggedInData';
  final _userProfileKey = 'userProfile';
  final _useBioMetricsKey = 'useBioMetrics';
  final _userProviderProfileKey = 'userProviderProfile';
  final _countLoginResumeKey = '_countLoginResumeKey';

  SignedInData? get signedInData => _signedInData;
  SignedInData? _signedInData;
  bool? _useBioMetrics;
  int? _countLoginResume;

  bool get isLogin => _signedInData != null;

  Future _putObject({required String key, required dynamic object}) {
    if (object == null) {
      return _box.put(key, null);
    }
    final json = jsonEncode(object.toJson());
    return _box.put(key, json);
  }

  T? _objectFromKey<T>(
      {required String key, required _ObjectGenerator<T> generator}) {
    String? json = _box.get(key);
    if (json == null) {
      return null;
    }
    final map = jsonDecode(json) as Map<String, dynamic>;
    return generator.call(map);
  }

  Future<void> clear() async {
    _useBioMetrics = false;
    _signedInData = null;
    _countLoginResume = 0;
    await _box.clear();
  }

  Future setSignedInData(SignedInData signedInData) {
    _signedInData = signedInData;
    return _putObject(key: _signedInDataKey, object: signedInData);
  }

  SignedInData? _getSignedInData() {
    return _objectFromKey<SignedInData>(
      key: _signedInDataKey,
      generator: (json) => SignedInData.fromJson(json),
    );
  }

  String? get token {
    return _signedInData?.token;
  }

  String? get email {
    return _signedInData?.email;
  }

  // Future setUserModel(UserProfileModel user) async {
  //   return _putObject(key: _userProfileKey, object: user);
  // }

  // UserProfileModel? get user {
  //   return _objectFromKey<UserProfileModel>(
  //     key: _userProfileKey,
  //     generator: (json) => UserProfileModel.fromJson(json),
  //   );
  // }

  bool get useBioMetrics {
    return _useBioMetrics ??= (_box.get(_useBioMetricsKey) ?? false);
  }

  int get countLoginResume {
    return _countLoginResume ??= (_box.get(_countLoginResumeKey) ?? 0);
  }

  FutureOr<void> toggleBiometrics(bool isEnable) {
    _useBioMetrics = isEnable;
    return _box.put(_useBioMetricsKey, isEnable);
  }

  FutureOr<void> setCountLoginResume(int  countLoginResume) {
    _countLoginResume = countLoginResume;
    return _box.put(_countLoginResumeKey, countLoginResume);
  }

  Future<void> updateToken(String refreshToken) async {
    _signedInData = _signedInData?.copyWith(token: refreshToken);
    await _putObject(key: _signedInDataKey, object: _signedInData);
  }

}
