//ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    log('/------SharedPreference Initialized------/');
    return;
  }

  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    await _sharedPreferences!.setString('themeMode', mode.name);
  }

  static String getThemeMode() {
    try {
      return _sharedPreferences!.getString('themeMode')!;
    } catch (e) {
      return ThemeMode.light.name;
    }
  }
}
