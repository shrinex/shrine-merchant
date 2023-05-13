/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

class Tuple<A, B> {
  final A $0;
  final B $1;

  Tuple(this.$0, this.$1);
}

class Tuple3<A, B, C> extends Tuple<A, B> {
  final C $2;

  Tuple3(A $0, B $1, this.$2) : super($0, $1);
}
