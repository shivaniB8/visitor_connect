enum BuildVariant {
  dev,
  prod,
}

class BuildConfig {
  final BuildVariant buildVariant;
  final String scheme;
  final String apiBaseUrl;
  static BuildConfig? _instance;

  factory BuildConfig({
    required BuildVariant buildVariant,
    String scheme = 'https',
    required String apiBaseUrl,
  }) {
    _instance ??= BuildConfig._internal(
      buildVariant,
      scheme,
      apiBaseUrl,
    );
    return _instance!;
  }

  BuildConfig._internal(
    this.buildVariant,
    this.scheme,
    this.apiBaseUrl,
  );

  static BuildConfig? get instance {
    return _instance;
  }
}
