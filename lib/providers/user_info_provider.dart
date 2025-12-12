import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_scaffold/models/base/user_info.dart';

part 'user_info_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfoState extends _$UserInfoState {
  @override
  UserInfo? build() {
    ref.keepAlive();
    return null;
  }

  void setUserInfo(UserInfo userInfo) {
    state = userInfo;
  }

  void clearUserInfo() {
    state = null;
  }

  bool isLogined() {
    return state != null;
  }
}
