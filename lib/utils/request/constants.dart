/// HTTP 请求相关常量，可以在请求头中使用，确保一致性和避免硬编码
class HttpConstants {
  // Content-Type 相关常量
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'application/x-www-form-urlencoded';
  static const String contentTypeMultipart = 'multipart/form-data';
  static const String contentTypeXml = 'application/xml';
  static const String contentTypeText = 'text/plain';
  
  // Header 字段名称常量
  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String userAgent = 'User-Agent';
  static const String accept = 'Accept';
  
  // 常用的 Headers 组合
  static const Map<String, String> requestJsonContent = {
    contentType: contentTypeJson,
  };
  
  static const Map<String, String> requestFormContent = {
    contentType: contentTypeForm,
  };

  // 常用的 Accept 组合
  static const Map<String, String> responseJsonAccept = {
    accept: contentTypeJson,
  };
  
}


