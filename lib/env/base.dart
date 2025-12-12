abstract class AppEnvironment {
  /// 环境名称
  String get name;

  /// 应用名称
  String get appName;

  /// request base URL
  String get baseUrl;

  ///  api key， 打包等级别使用
  String get apiKey;
}