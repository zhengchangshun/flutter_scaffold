import 'package:dio/dio.dart';
import 'package:flutter_scaffold/env/app_env.dart';
import 'package:flutter_scaffold/utils/logger/index.dart';

/// 请求拦截器
///
/// 职责：
/// - 添加动态的认证信息 (token)
/// - 添加设备信息
/// - 记录请求开始时间
///
/// 重要说明：
/// RequestOptions 在到达拦截器时，已经由 Dio 自动完成了以下合并：
/// - BaseOptions + 用户传入的 Options
/// - Headers 智能合并 (用户配置优先)
/// - Timeout 等配置的继承和覆盖

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 注意：RequestOptions 到达这里时，Dio 已经自动合并了 BaseOptions 和用户传入的 Options

    // 1. 添加认证 token
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 2. 添加设备信息
    options.headers['Device-Info'] = await _getDeviceInfo();

    // 3. 记录请求开始时间（用于计算请求耗时）
    options.extra['requestStartTime'] = DateTime.now().millisecondsSinceEpoch;

    if (!AppConfig.isProduction()) {
      Log.info('请求配置: ${options.method} ${options.uri}');
      Log.debug('请求Headers: ${options.headers}');
    }

    handler.next(options);
  }

  Future<String?> _getToken() async {
    // 从本地存储获取 token，例如使用 shared_preferences
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('auth_token');
    return 'your_token_here'; // 临时返回测试 token
  }

  Future<String> _getDeviceInfo() async {
    // 获取设备信息
    // 可以使用 device_info_plus 包
    return 'Flutter/${const String.fromEnvironment('FLUTTER_VERSION')}';
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 请求阶段的错误处理
    final requestTime = err.requestOptions.extra['requestStartTime'];
    if (requestTime != null && !AppConfig.isProduction()) {
      final cost = DateTime.now().millisecondsSinceEpoch - requestTime;
      Log.error('请求失败: ${err.requestOptions.uri}, 耗时: ${cost}ms', err);
    }

    handler.next(err);
  }
}
