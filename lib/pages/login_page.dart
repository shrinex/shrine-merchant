/*
 * Created by Archer on 2023/5/13.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:levir/levir.dart';
import 'package:provider/provider.dart';
import 'package:shrine_merchant/basics/environment.dart';
import 'package:shrine_merchant/utils/toast_state_mixin.dart';
import 'package:shrine_merchant/utils/validator.dart';
import 'package:shrine_merchant/viewmodels/login_page_view_model.dart';
import 'package:shrine_merchant/views/cut_corners_border.dart';
import 'package:shrine_merchant/views/reminder.dart';

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
    with
        ToastStateMixin<LoginPage>,
        ViewModelProviderStateMixin<LoginPage, LoginPageViewModel> {
  @override
  LoginPageViewModel createViewModel() => LoginPageViewModel();

  late final _loginEnabled = ValueNotifier<bool>(false);
  late final _unameController = TextEditingController();
  late final _passwdController = TextEditingController();

  @override
  void bindViewModel() {
    _unameController.addListener(_rebuildIfNeeded);
    _passwdController.addListener(_rebuildIfNeeded);

    viewModel.outputs.accessToken.listen((event) async {
      final env = context.read<Environment>();
      await env.login(event.value);
    });

    viewModel.outputs.errorOccurred.listen((message) {
      messenger.showToast(
        toastDuration: const Duration(seconds: 4),
        gravity: ToastGravity.TOP,
        child: Reminder(message),
      );
    });
  }

  bool _canRebuild() {
    return Validator.isUsername(_unameController.text, failOnEmpty: true) &&
        Validator.isPassword(_passwdController.text, failOnEmpty: true);
  }

  void _rebuildIfNeeded() {
    final canRebuild = _canRebuild();
    if (_loginEnabled.value != canRebuild) {
      _loginEnabled.value = canRebuild;
    }
  }

  void _signInIfPossible(BuildContext context) {
    if (Form.of(context).validate()) {
      viewModel.inputs.signIn(
        _unameController.text,
        _passwdController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  @override
  void dispose() {
    _passwdController.dispose();
    _unameController.dispose();
    super.dispose();
  }
}

extension on _LoginPageState {
  Widget _build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _evalAreaWidth(context),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Builder(builder: (context) {
                return Column(
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
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _unameTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      autocorrect: false,
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
      validator: (text) {
        if (Validator.isUsername(text)) {
          return null;
        }
        return "用户名仅支持5-8位字母和数字";
      },
    );
  }

  Widget _passwdTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      controller: _passwdController,
      cursorColor: colorScheme.onSurface,
      decoration: InputDecoration(
        labelText: "密码",
        border: CutCornersBorder(
          borderSide: BorderSide(
            color: colorScheme.onPrimary,
            width: 0.3,
          ),
        ),
      ),
      validator: (text) {
        if (Validator.isPassword(text)) {
          return null;
        }
        return "密码仅支持5-8位字母和数字";
      },
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
                  _signInIfPossible(context);
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: ValueListenableBuilder(
              valueListenable: _loginEnabled,
              builder: (BuildContext context, bool value, Widget? child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ),
                  onPressed: value ? () => _signInIfPossible(context) : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Text(
                      "登录",
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
