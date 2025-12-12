import './base.dart';

class StagingEnvironment implements AppEnvironment {
  @override
  String get name => 'staging';

  @override
  String get baseUrl => 'https://pes-test.sanhuagroup.com';

  @override
  String get apiKey => '';

  @override
  String get appName => 'PES2.0  Staging';
}
