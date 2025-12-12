import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  UserInfo({this.username, this.email, this.token, this.id, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
