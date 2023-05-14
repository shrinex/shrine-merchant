/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';
import 'package:shrine_merchant/api/endpoint.dart';
import 'package:shrine_merchant/api/types/authc/login_req.dart';
import 'package:shrine_merchant/api/types/authc/login_resp.dart';

extension Authc on Service {
  Stream<LoginResp> signIn(LoginReq req) {
    return observe(ClientHttpRequest(
      body: req,
      path: "/api/v1/authc/login",
      method: HttpMethod.post,
      baseUrl: Endpoint.authc.rawValue,
    )).map(($0) => LoginResp.fromJson($0));
  }
}
