import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/pages/register.dart';
import 'package:flutter_scaffold/pages/login.dart';

final List<RouteBase> accountRoutes = [
  GoRoute(
    name: AppRouterConstant.login.name,
    path: AppRouterConstant.login.path,
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    name: AppRouterConstant.register.name,
    path: AppRouterConstant.register.path,
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterPage();
    },
  ),
];
