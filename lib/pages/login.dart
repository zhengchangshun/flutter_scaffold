import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/models/base/user_info.dart';
import 'package:flutter_scaffold/providers/user_info_provider.dart';

final userInfoMockData = UserInfo.fromJson({
  "username": "TestUser",
  "email": "TestUser@123.com",
  "token": "abcdefg1234567",
  "id": "10001",
});

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Future<void> onLogin() async {
    // 延迟 2s
    await Future.delayed(Duration(milliseconds: 500));
    // 防止跨异步使用已卸载的 context
    if (!mounted) return;
    // 先设置登录态，再导航，避免被守卫重定向回登录页
    ref.read(userInfoStateProvider.notifier).setUserInfo(userInfoMockData);
    // 读取当前登录页的 redirect 参数，优先跳回原目标
    final uri = GoRouterState.of(context).uri;
    final redirect = uri.queryParameters['redirect'];
    if (redirect != null && redirect.isNotEmpty) {
      context.go(redirect);
    } else {
      context.go(AppRouterConstant.home.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('LoginPage', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onLogin,
            child: const Text('模拟登录。调用 Provider'),
          ),
        ],
      ),
    );
  }
}
