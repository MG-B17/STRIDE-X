import 'package:flutter/material.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String selectedTheme = AppStrings.systemTheme;

  void selectTheme({required String mode}) {
    themeMode = _appthemeselector(mode: mode);
    selectedTheme = mode;
    CacheHelper.saveData(key: AppKeys.appMode, value: mode);
    notifyListeners();
  }

  void loadTheme() {
    final String theme =
        CacheHelper.getData(key: AppKeys.appMode) ?? AppStrings.systemTheme;
      selectedTheme =theme;  
      themeMode = _appthemeselector(mode: theme);
    notifyListeners();
  }

  ThemeMode _appthemeselector({required String mode}) {
    switch (mode) {
      case AppStrings.darkTheme:
        return ThemeMode.dark;
      case AppStrings.lightTheme:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }


}
