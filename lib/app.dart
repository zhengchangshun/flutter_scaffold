import 'package:flutter/material.dart';
import 'package:flutter_scaffold/env/app_env.dart';
import 'package:flutter_scaffold/routers/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2D8CF0)),
      ),
      routerConfig: appRouter,
    );
  }
}
