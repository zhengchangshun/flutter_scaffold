import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/components/bottom_navigation.dart';
import 'package:flutter_scaffold/routers/constant.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  RouteConfig getRouteConfig() {
    final location = GoRouterState.of(context).uri;
    final config = AppRouterConstant.resolveByPath(location.path);
    return config!;
  }

  String getAppBarTitle() {
    final config = getRouteConfig();
    return config.title ?? 'App';
  }

  bool isNeedBottomBar() {
    final config = getRouteConfig();
    return config.needBottomBar ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getAppBarTitle())),
      body: widget.child,
      bottomNavigationBar: isNeedBottomBar() ? const BottomNavigation() : null,
    );
  }
}
