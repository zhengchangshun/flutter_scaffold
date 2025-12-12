import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/providers/user_info_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userInfoStateProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ProfilePage', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Text('当前用户：${user?.username ?? "未登录"}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // 清除登录态并回到登录页
              ref.read(userInfoStateProvider.notifier).clearUserInfo();
              context.go(AppRouterConstant.login.path);
            },
            child: const Text('退出登录'),
          ),
        ],
      ),
    );
  }
}
