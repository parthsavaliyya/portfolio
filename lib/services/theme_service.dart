import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class ThemeService extends GetxService {
  static ThemeService get to => Get.find();

  final _isDark = true.obs;

  bool get isDark => _isDark.value;

  ThemeData get currentTheme =>
      _isDark.value ? AppTheme.darkTheme : AppTheme.lightTheme;

  ThemeMode get themeMode => _isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark.value = !_isDark.value;
    Get.changeTheme(currentTheme);
  }
}
