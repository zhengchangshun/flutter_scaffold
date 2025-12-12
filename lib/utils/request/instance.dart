// lib/core/network/dio_instance.dart
import 'package:dio/dio.dart';
import 'package:flutter_scaffold/env/app_env.dart';
import './interceptors/request_interceptor.dart';
import './interceptors/response_interceptor.dart';
import './constants.dart';

/// Dio 实例管理器
///
/// 设计原则：
/// - 单例模式确保全局唯一配置
/// - 基础配置在初始化时设定，避免运行时动态修改
/// - 如需不同配置，推荐使用请求级别的 Options 或创建新的 Dio 实例
class DioInstance {
  static final DioInstance _instance = DioInstance._internal();
  factory DioInstance() => _instance;

  late Dio _dio;

  DioInstance._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          ...HttpConstants.requestJsonContent,
          ...HttpConstants.responseJsonAccept,
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // 添加自定义拦截器
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(ResponseInterceptor());

    // 添加日志拦截器（最后添加，以便看到最终的请求配置）
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Dio get dio => _dio;
}
