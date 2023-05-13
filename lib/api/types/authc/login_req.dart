/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:json_annotation/json_annotation.dart';

part 'login_req.g.dart';

@JsonSerializable()
class LoginReq {
  // 系统类型
  final int sysType;

  // 平台
  final String platform;

  // 用户名
  final String username;

  // 密码
  final String password;

  LoginReq({
    this.sysType = 1,
    this.platform = "web",
    required this.username,
    required this.password,
  });

  factory LoginReq.fromJson(Map<String, dynamic> json) =>
      _$LoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReqToJson(this);
}
