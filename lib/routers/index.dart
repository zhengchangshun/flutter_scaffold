import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/layout/main_layout.dart';
import './modules/account.dart';
import './modules/home.dart';
import './hooks/guard.dart';
import './hooks/observers.dart';
import './hooks/error.dart';

// 统一处理 appBar 和底部导航栏的 ShellRoute 列表
final List<RouteBase> shellRouteList = [
  ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child) {
      return MainLayout(child: child);
    },
    routes: [...accountRoutes, ...homeRoutes],
  ),
];

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: shellRouteList,
  redirect: RouteGuard.authGuard,
  observers: [RouterObserver()],
  errorBuilder: errorBuilder,
);