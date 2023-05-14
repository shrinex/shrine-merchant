/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:get_it/get_it.dart';
import 'package:levir/levir.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shrine_merchant/api/types/response.dart';
import 'package:shrine_merchant/api/types/response_code.dart';
import 'package:shrine_merchant/basics/environment.dart';

extension Materialize<R extends Response, N extends Notification<R>>
    on Stream<N> {
  Stream<String> asError({bool share = false}) {
    final downstream = where((event) {
      if (event.isOnError) {
        return true;
      }

      if (event.isOnData) {
        return event.requireData.code != 0;
      }

      return false;
    }).doOnData((event) {
      // 清理失效的会话
      if (event.isOnData &&
          ResponseCode.sessions.containsRawValue(event.requireData.code)) {
        GetIt.I<Environment>().logout();
      }
    }).map((event) {
      if (event.isOnError) {
        return event.errorAndStackTrace?.error;
      }

      return event.requireData;
    }).map((event) {
      if (event is ErrorEnvelope) {
        return event.message;
      }

      if (event is R) {
        return event.message;
      }

      return ErrorEnvelope.internal.message;
    });

    if (share) {
      return downstream.share();
    }

    return downstream;
  }

  Stream<E> asData<E>({bool share = false}) {
    final downstream = where((event) => event.isOnData)
        .where((event) => event.requireData.code == 0)
        .map((event) => event.requireData.data)
        .whereType<E>();

    if (share) {
      return downstream.share();
    }

    return downstream;
  }
}
