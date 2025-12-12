# frist_demo

Flutter 脚手架

## 前置依赖等

### 添加依赖
```
flutter pub get
```

### 添加生成代码
```
flutter pub run build_runner build
```

### 在 cicd 中使用生成代码

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## 启动方式

### 开发环境

```
flutter run
# 或者
flutter run --dart-define=APP_ENV=development 
```

### 测试环境

```
# 测试环境
flutter run --dart-define=APP_ENV=staging
```

### 生产环境

```
# 生产环境
flutter run --dart-define=APP_ENV=production
```

### 指定设备

```
# 指定设备
flutter run -d iPhone14 --dart-define=APP_ENV=development
```

## VS Code 启动配置
.vscode/launch.json
```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "🚀 Development",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=APP_ENV=development",
      ]
    },
    {
      "name": "🧪 Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=APP_ENV=staging",
      ]
    },
    {
      "name": "📦 Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=APP_ENV=production",
      ]
    },
    {
      "name": "🔍 Development (Profile)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=APP_ENV=development",
        "--profile"
      ]
    },
    {
      "name": "📱 Development (Chrome)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=APP_ENV=development",
        "-d", "chrome"
      ]
    }
  ]
}
```

## 构建命令 APK

```
# 测试环境
flutter build apk --dart-define=APP_ENV=staging

# 生产环境
flutter build apk --dart-define=APP_ENV=production
```