import './base.dart';

class ProductionEnvironment implements AppEnvironment {
    @override
  String get name => 'production';
  
  @override
  String get baseUrl => 'https://pes.sanhuagroup.com';
  
  @override
  String get apiKey => '';
  
  @override
  String get appName => 'PES2.0 Production';
}