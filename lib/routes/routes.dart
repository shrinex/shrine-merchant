/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shrine_merchant/basics/environment.dart';
import 'package:shrine_merchant/pages/home_page.dart';
import 'package:shrine_merchant/pages/login_page.dart';

/// Can be used in Web environment.
class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

final rootNavKey = GlobalKey<NavigatorState>(debugLabel: "rootNavKey");

GoRouter shrineRouter = GoRouter(
  navigatorKey: rootNavKey,
  routes: [
    GoRoute(path: "/", builder: (ctx, state) => const HomePage()),
    GoRoute(path: "/login", builder: (ctx, state) => const LoginPage()),
  ],
  redirect: (ctx, state) {
    // if the user is not logged in, they need to login
    final env = ctx.watch<Environment>();
    final bool loggedIn = env.loggedIn;
    final bool loggingIn = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return '/';
    }

    // no need to redirect at all
    return null;
  },
);
