import './base.dart';
import './development.dart';
import './staging.dart';
import './production.dart';
import 'package:flutter_scaffold/utils/logger/index.dart';

class AppConfig {
  static late final AppEnvironment env;

  static void initialize({String environment = 'development'}) {
    switch (environment) {
      case 'production':
        env = ProductionEnvironment();
        break;
      case 'staging':
        env = StagingEnvironment();
        break;
      case 'development':
        env = DevelopmentEnvironment();
        break;
      default:
        env = DevelopmentEnvironment();
    }

    // 验证注册成功，使用全局 getter
    Log.info('环境: ${env.name}');
    Log.info('应用: ${env.appName}');
    Log.info('API baseUrl: ${env.baseUrl}');
    Log.info('=== 环境变量注入完成 ===');
  }

  // 便捷属性访问器
  static String get baseUrl => env.baseUrl;
  static String get appName => env.appName;
  static String get apiKey => env.apiKey;
  static String get name => env.name;

  // 是否为生产环境（静态方法）
  static bool isProduction() {
    return env.name == 'production';
  }
}
