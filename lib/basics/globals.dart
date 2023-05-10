/*
 * Created by Archer on 2022/12/17.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:levir/levir.dart';

/// [Globals] captures the global objects that the app wants access to
abstract class Globals {
  /// A type that exposes endpoints for fetching Shrine data
  static Service get apiService => _apiService;
  static late Service _apiService;

  /// A user defaults key-value store
  static KeyValueStore get userDefaults => _userDefaults;
  static late KeyValueStore _userDefaults;

  /// The amount of time to debounce signals by. Default value is `0.3`
  static const double debounceInterval = 0.3;

  /// Must be called before [runApp]
  static void initialize({
    required Service apiService,
    required KeyValueStore userDefaults,
  }) {
    _apiService = apiService;
    _userDefaults = userDefaults;
  }

  /// Changes part of global object
  static void replace({
    Service? apiService,
    KeyValueStore? userDefaults,
  }) {
    if (apiService != null) {
      _apiService = apiService;
    }
    if (userDefaults != null) {
      _userDefaults = userDefaults;
    }
  }
}
