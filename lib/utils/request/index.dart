
import 'package:dio/dio.dart';
import './instance.dart';

/// HTTP 请求管理器
/// 
/// 功能特性:
/// - 统一的错误处理
/// - 支持文件上传下载
/// - 支持请求取消
/// - 通过 RequestInterceptor 自动添加认证 token 和设备信息
/// 
/// 架构说明:
/// - RequestOptions 自动继承 Dio 的基础配置 (baseUrl, headers, timeout 等)
/// - RequestInterceptor 负责添加动态配置 (token, 设备信息等)
/// - 自定义 Options 会与基础配置自然合并
/// 

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  factory HttpManager() => _instance;
  
  late Dio _dio;
  
  HttpManager._internal() {
    _dio = DioInstance().dio;
  }
  
  // GET 请求
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '网络请求失败';
    }
  }
  
  // POST 请求
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '网络请求失败';
    }
  }
  
  // PUT 请求
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '网络请求失败';
    }
  }
  
  // DELETE 请求
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '网络请求失败';
    }
  }
  
  // 文件上传
  Future<dynamic> upload(
    String path,
    String filePath, {
    Map<String, dynamic>? formData,
    CancelToken? cancelToken,
  }) async {
    try {
      final FormData data = FormData.fromMap({
        ...?formData,
        'file': await MultipartFile.fromFile(filePath),
      });
      
      final response = await _dio.post(
        path,
        data: data,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '文件上传失败';
    }
  }
  
  // 下载文件
  Future<dynamic> download(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw e.error ?? '文件下载失败';
    }
  }
  
  // 创建取消令牌
  CancelToken createCancelToken() {
    return CancelToken();
  }
}