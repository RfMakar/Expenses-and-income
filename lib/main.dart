import 'package:budget/provider_app.dart';
import 'package:budget/screens/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
  Intl.defaultLocale = 'ru';
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderApp(),
      child: Consumer<ProviderApp>(
        builder: (context, provider, child) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FormBuilderLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
            ],
            theme: MyThemeApp.themeLight,
            darkTheme: MyThemeApp.themeDark,
            themeMode: ThemeMode.system,
            home: const ScreenHome(),
          );
        },
      ),
    );
  }
}

class MyThemeApp {
  static const colorTheme = Color.fromRGBO(255, 215, 0, 1);
  static ThemeData themeLight = ThemeData(
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
      showDragHandle: true,
    ),
  );
  static ThemeData themeDark = ThemeData(
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
      showDragHandle: true,
    ),
  );
}
