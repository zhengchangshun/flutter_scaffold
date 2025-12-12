import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/providers/user_info_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Home 页面'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => {
              context.go('${AppRouterConstant.login.path}?redirect=/')
            },
            child: const Text('跳转到登录页 /login'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go(AppRouterConstant.register.path),
            child: const Text('跳转到注册页 /register'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go(AppRouterConstant.profile.path),
            child: const Text('跳转到个人中心 /profile'),
          ),
          const SizedBox(height: 12),
          Text( 
            '当前用户：${ref.watch(userInfoStateProvider)?.username ?? "未登录"}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
