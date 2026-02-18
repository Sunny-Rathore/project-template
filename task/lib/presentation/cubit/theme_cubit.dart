import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/core/app_export.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
    : super(
        PrefUtils.getThemeMode() == ThemeMode.light.name
            ? ThemeMode.light
            : ThemeMode.dark,
      );

  FutureOr toggleTheme() async {
    ThemeMode mode = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await PrefUtils.setThemeMode(mode);
    emit(mode);
  }
}
