import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/pages/home.dart';
import 'package:flutter_scaffold/pages/profile.dart';

final List<GoRoute> homeRoutes = [
  // 主页
  GoRoute(
    name: AppRouterConstant.home.name,
    path: AppRouterConstant.home.path,
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
  ),
  // 个人中心
  GoRoute(
    name: AppRouterConstant.profile.name,
    path: AppRouterConstant.profile.path,
    builder: (BuildContext context, GoRouterState state) {
      return const ProfilePage();
    },
  ),
];
