import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppTheme {
  BehaviorSubject<ThemeMode> bsThemeMode = BehaviorSubject<ThemeMode>.seeded(ThemeMode.system);
  get themeMode => bsThemeMode.value;
  get themeStream => bsThemeMode.stream;
}

final appTheme = AppTheme();