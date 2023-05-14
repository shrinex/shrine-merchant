/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

enum ResponseCode implements RawEnum<int> {
  sessionExpired(625),
  sessionReplaced(626),
  sessionOverflow(627),
  ;

  @override
  final int rawValue;

  static List<ResponseCode> get sessions => [
        ResponseCode.sessionExpired,
        ResponseCode.sessionReplaced,
        ResponseCode.sessionOverflow
      ];

  const ResponseCode(
    this.rawValue,
  );
}
