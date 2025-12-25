import './base.dart';

class ProductionEnvironment implements AppEnvironment {
    @override
  String get name => 'production';
  
  @override
  String get baseUrl => 'https://pro.sanhuagroup.com';
  
  @override
  String get apiKey => '';
  
  @override
  String get appName => 'App Production';
}
