/*
 * Created by Archer on 2023/5/14.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

abstract class Validator {
  static final _unameRegex = RegExp(r'^[a-zA-Z0-9]{5,8}$');
  static final _passwdRegex = RegExp(r'^[@$_a-zA-Z0-9]{5,8}$');

  static bool isUsername(String? input, {bool failOnEmpty = false}) {
    return regexMatch(_unameRegex, input, failOnEmpty: failOnEmpty);
  }

  static bool isPassword(String? input, {bool failOnEmpty = false}) {
    return regexMatch(_passwdRegex, input, failOnEmpty: failOnEmpty);
  }

  static bool regexMatch(RegExp pattern, String? input,
      {bool failOnEmpty = false}) {
    if (input != null && input.isNotEmpty) {
      return pattern.hasMatch(input);
    }

    return !failOnEmpty;
  }
}
