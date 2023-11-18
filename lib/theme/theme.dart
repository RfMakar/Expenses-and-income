import 'package:flutter/material.dart';

const colorTheme = Color.fromRGBO(255, 215, 0, 1);

const themeMode = ThemeMode.system;

final themeLight = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: colorTheme,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: colorTheme,
    centerTitle: true,
  ),
  toggleButtonsTheme: const ToggleButtonsThemeData(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    dragHandleColor: colorTheme,
    showDragHandle: true,
  ),
  snackBarTheme: const SnackBarThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
  ),
);
final themeDark = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: colorTheme,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  toggleButtonsTheme: const ToggleButtonsThemeData(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    dragHandleColor: colorTheme,
    showDragHandle: true,
  ),
  snackBarTheme: const SnackBarThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
  ),
);
