/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

class Response<T> {
  late final int code;
  late final String message;

  // can safely unwrap when code == 0
  late final T? data;

  Response();
}
