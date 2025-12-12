import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Map<String, dynamic>> _tabBarList = [
    {
      'icon': Icons.home,
      'label': AppRouterConstant.home.title,
      'path': AppRouterConstant.home.path,
    },
    {
      'icon': Icons.person,
      'label': AppRouterConstant.profile.title,
      'path': AppRouterConstant.profile.path,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 根据当前 location 同步选中索引
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouterConstant.profile.path)) {
      _currentIndex = 1;
    } else {
      _currentIndex = 0; // 默认首页
    }
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    context.go(_tabBarList[index]['path']);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onTap,
      items: List.generate(
        _tabBarList.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(_tabBarList[index]['icon']),
          label: _tabBarList[index]['label'],
        ),
      ),
    );
  }
}
