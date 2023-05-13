/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:shrine_merchant/api/types/authc/access_token.dart';
import 'package:shrine_merchant/api/types/response.dart';

part 'login_resp.g.dart';

@JsonSerializable()
class LoginResp extends Response<AccessToken> {
  LoginResp();

  factory LoginResp.fromJson(Map<String, dynamic> json) =>
      _$LoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRespToJson(this);
}
