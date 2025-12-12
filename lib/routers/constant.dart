class RouteConfig {
  // 路由路径
  final String path;
  // 路由名称
  final String name;
  // 页面标题
  final String? title;
  // 是否需要底部导航栏
  final bool? needBottomBar;
  // 是否需要认证
  final bool? needAuth;

  RouteConfig({
    required this.path,
    required this.name,
    this.title,
    this.needBottomBar = false,
    this.needAuth = false,
  });

  factory RouteConfig.fromMap(Map<String, dynamic> map) {
    return RouteConfig(
      path: map['path'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      needBottomBar: map['needBottomBar'] ?? false,
      needAuth: map['needAuth'] ?? false,
    );
  }
}

/// 路由常量定义
/// 包含路径、名称、标题等信息
/// 新增路由时请在此处添加对应常量，并更新 allRouteConfig 列表
class AppRouterConstant {
  // 登录
  static final login = RouteConfig(path: '/login', name: 'login', title: '登录');
  // 注册
  static final register = RouteConfig(
    path: '/register',
    name: 'register',
    title: '注册',
  );
  // 首页
  static final home = RouteConfig(
    path: '/',
    name: 'home',
    title: '首页',
    needBottomBar: true,
    needAuth: true,
  );
  // 个人中心
  static final profile = RouteConfig(
    path: '/profile',
    name: 'profile',
    title: '个人中心',
    needBottomBar: true,
    needAuth: true,
  );

  // 所有路由列表
  static List<RouteConfig> allRouteConfig = [login, register, home, profile];

  // 根据路径解析对应的 RouteConfig（简单匹配，按前缀判断）
  static RouteConfig? resolveByPath(String path) {
    for (var config in allRouteConfig) {
      if (path == config.path) {
        return config;
      }
    }
    return RouteConfig.fromMap({});
  }
}
