/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:levir/levir.dart';
import 'package:provider/provider.dart';
import 'package:shrine_merchant/basics/environment.dart';
import 'package:shrine_merchant/viewmodels/login_page_view_model.dart';
import 'package:shrine_merchant/views/cut_corners_border.dart';

const _horizontalPadding = 24.0;

double _evalAreaWidth(BuildContext context) {
  return min(360, MediaQuery.of(context).size.width - 2 * _horizontalPadding);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ViewModelProviderStateMixin<LoginPage, LoginPageViewModel> {
  @override
  LoginPageViewModel createViewModel() => LoginPageViewModel();

  late final _unameController = TextEditingController();
  late final _passwdController = TextEditingController();

  @override
  void bindViewModel() {
    viewModel.outputs.accessToken.listen((event) async {
      final env = context.read<Environment>();
      await env.login(event.value);
    });

    viewModel.outputs.errorOccurred.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _evalAreaWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 34),
                const SizedBox(height: 40),
                _unameTextField(context),
                const SizedBox(height: 16),
                _passwdTextField(context),
                const SizedBox(height: 24),
                _loginButton(context),
                const SizedBox(height: 62),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _unameTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _unameController,
      textInputAction: TextInputAction.next,
      cursorColor: colorScheme.onSurface,
      decoration: InputDecoration(
        labelText: "用户名",
        border: CutCornersBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary,
            width: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _passwdTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _passwdController,
      cursorColor: colorScheme.onSurface,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "密码",
        border: CutCornersBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary,
            width: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Focus(
            onKey: (node, event) {
              if (event is RawKeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.enter) {
                  viewModel.inputs.signIn(
                    _unameController.text,
                    _passwdController.text,
                  );
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              onPressed: () {
                viewModel.inputs.signIn(
                  _unameController.text,
                  _passwdController.text,
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Text(
                  "登录",
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
