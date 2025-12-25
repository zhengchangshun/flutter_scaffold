import './base.dart';

class StagingEnvironment implements AppEnvironment {
  @override
  String get name => 'staging';

  @override
  String get baseUrl => 'https://pre.sanhuagroup.com';

  @override
  String get apiKey => '';

  @override
  String get appName => 'App  Staging';
}
