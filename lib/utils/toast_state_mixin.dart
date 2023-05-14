/*
 * Created by Archer on 2023/5/14.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shrine_merchant/routes/routes.dart';

/// Helps manage the lifecycle of [FToast]
mixin ToastStateMixin<T extends StatefulWidget> on State<T> {
  late FToast messenger = FToast();

  @override
  void initState() {
    super.initState();
    messenger.init(rootNavKey.currentContext!);
  }
}
