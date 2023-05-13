/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

enum Endpoint implements RawEnum<String> {
  authc("http://localhost:8001"),
  authz("http://localhost:8002"),
  ;

  @override
  final String rawValue;

  const Endpoint(
    this.rawValue,
  );
}
