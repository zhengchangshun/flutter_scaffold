import 'package:dio/dio.dart';
import 'package:flutter_scaffold/env/app_env.dart';
import 'package:flutter_scaffold/utils/logger/index.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 计算请求耗时
    final requestTime = response.requestOptions.extra['requestStartTime'];
    if (requestTime != null) {
      final cost = DateTime.now().millisecondsSinceEpoch - requestTime;
      if (!AppConfig.isProduction()) {
        Log.info(
          '响应成功: ${response.requestOptions.uri}, 耗时: ${cost}ms, 状态码: ${response.statusCode}',
        );
      }
    }
    // 统一响应格式处理
    final processedResponse = _processResponse(response);

    handler.next(processedResponse);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!AppConfig.isProduction()) {
      Log.error('响应错误: ${err.type} - ${err.message}', err);
    }

    // 根据错误类型进行统一处理
    final processedError = _processError(err);

    handler.next(processedError);
  }

  Response _processResponse(Response response) {
    // 如果后端有统一的响应格式，可以在这里进行统一处理
    // 例如：{ "code": 0, "message": "success", "data": {} }

    if (response.data is Map<String, dynamic>) {
      final Map<String, dynamic> data = response.data;

      // 检查业务状态码
      if (data.containsKey('code')) {
        final code = data['code'];
        if (code != 0 && code != 200) {
          // 业务逻辑错误，抛出 DioException
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: data['message'] ?? '业务逻辑错误',
          );
        }

        // 返回真正的数据部分
        if (data.containsKey('data')) {
          response.data = data['data'];
        }
      }
    }

    return response;
  }

  DioException _processError(DioException err) {
    String errorMessage;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '网络连接超时，请检查网络后重试';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleBadResponse(err);
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求已取消';
        break;
      case DioExceptionType.unknown:
        if (err.error?.toString().contains('SocketException') == true) {
          errorMessage = '网络连接失败，请检查网络设置';
        } else {
          errorMessage = '网络异常: ${err.error}';
        }
        break;
      case DioExceptionType.badCertificate:
        errorMessage = '证书验证失败';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '连接错误，请检查网络连接';
        break;
    }

    // 创建新的 DioException 对象，因为 error 属性是 final 的
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
      message: errorMessage,
    );
  }

  String _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;

    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        _handleUnauthorized();
        return '登录已过期，请重新登录';
      case 403:
        return '访问被拒绝';
      case 404:
        return '请求的资源不存在';
      case 500:
      case 502:
      case 503:
        return '服务器内部错误，请稍后重试';
      default:
        return '网络错误: $statusCode';
    }
  }

  void _handleUnauthorized() {
    // token 过期处理，例如跳转到登录页
    // 注意：这里不要直接进行页面跳转，应该通过事件或状态管理来处理
    if (!AppConfig.isProduction()) {
      Log.warning('Token 已过期，需要重新登录');
    }

    // 例如：EventBus().fire(TokenExpiredEvent());
    // 或者：Get.find<AuthController>().logout();
  }
}
