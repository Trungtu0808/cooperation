class BuildConfigs {
  BuildConfigs({
    required this.appId,
    required this.flavor,
  });

  final String appId;
  final Flavor flavor;
}

const _flavorValue = {
  Flavor.dev: 'dev',
  Flavor.stag: 'stag',
  Flavor.prod: 'prod',
};

enum Flavor {
  prod,
  stag,
  dev;

  static Flavor? fromString(String flavor) {
    return _flavorValue.keys.firstWhere(
      (element) => _flavorValue[element] == flavor,
    );
  }
}
