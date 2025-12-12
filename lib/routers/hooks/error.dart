import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 简洁的 404 页面，仅展示“页面未找到”与返回按钮
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 未找到')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64),
            const SizedBox(height: 12),
            const Text('页面不存在或已移除'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('返回上一页'),
            ),
          ],
        ),
      ),
    );
  }
}

/// GoRouter 的 errorBuilder 适配到 404 展示
Widget errorBuilder(BuildContext context, GoRouterState state) {
  return const NotFoundPage();
}
