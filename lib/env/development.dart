import './base.dart';

class DevelopmentEnvironment implements AppEnvironment {
    @override
  String get name => 'development';
  
  @override
  String get baseUrl => 'https://test.sanhuagroup.com';
  
  @override
  String get apiKey => '';
  
  @override
  String get appName => 'App Development';
}
