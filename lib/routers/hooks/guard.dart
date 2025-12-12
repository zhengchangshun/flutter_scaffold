import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_scaffold/routers/constant.dart';
import 'package:flutter_scaffold/providers/user_info_provider.dart';

class RouteGuard {
	/// 统一路由守卫逻辑：
	/// - 目标为 login：已登录则根据 redirect 参数跳转或回首页；未登录允许进入登录页
	/// - 目标非 login：未登录则跳登录并携带 redirect；已登录允许继续
	static FutureOr<String?> authGuard(
		BuildContext context,
		GoRouterState state,
	) {
		// 从 Provider 读取登录态：userInfo 非空视为已登录
		final container = ProviderScope.containerOf(context, listen: false);
		final bool isLogined = container.read(userInfoStateProvider.notifier).isLogined();
		final Uri uri = state.uri;
		final bool isLoginRoute = uri.path == AppRouterConstant.login.path;
		final RouteConfig? targetConfig = AppRouterConstant.resolveByPath(uri.path);
		final bool needAuth = (targetConfig?.needAuth ?? false);
		final String? redirectParam = uri.queryParameters['redirect'];

		// 目标是登录页
		if (isLoginRoute) {
			if (isLogined) {
				// 已登录：优先使用 redirect 参数
				if (redirectParam != null && redirectParam.isNotEmpty) {
					return redirectParam;
				}
				// 无 redirect：回到首页
				return AppRouterConstant.home.path;
			}
			// 未登录：继续进入登录页
			return null;
		}

		// 目标不是登录页，且需要鉴权时才触发鉴权
		if (needAuth && !isLogined) {
			// 未登录：跳登录并带回跳地址（包含原始查询串）
			final current = uri.toString();
			final loginUri = Uri.parse(AppRouterConstant.login.path).replace(
				queryParameters: {'redirect': current},
			);
			return loginUri.toString();
		}

		// 已登录：允许导航
		return null;
	}
}
