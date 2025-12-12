import 'package:flutter/material.dart';
import 'package:flutter_scaffold/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scaffold/env/app_env.dart';
import 'package:flutter_scaffold/utils/logger/index.dart';
import 'package:flutter_scaffold/utils/storage/index.dart';

class _AppLifecycleObserver with WidgetsBindingObserver {
  // 在应用被摘除或后台时尝试清理日志输出，确保文件 flush
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      // 在一个微任务中异步等待 dispose，避免阻塞当前生命周期处理
      Future.microtask(() async {
        await Log.dispose();
      });
    }
  }
}

void main() async {
  // 确保 Flutter 框架已初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化日志配置
  Log.initialize();

  // 初始环境配置
  AppConfig.initialize(
    environment: const String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    ),
  );

  // 注册生命周期监听器
  WidgetsBinding.instance.addObserver(_AppLifecycleObserver());

  // 初始化本地存储
  await LocalStorage.init();

  // 运行应用（注入 Riverpod 的 ProviderScope）
  runApp(const ProviderScope(child: MyApp()));
}
