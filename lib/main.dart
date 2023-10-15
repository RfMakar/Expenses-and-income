import 'package:budget/provider_app.dart';
import 'package:budget/screen/home/screen_home.dart';
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
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: const Color.fromRGBO(255, 215, 0, 1),
              appBarTheme: const AppBarTheme(
                color: Color.fromRGBO(255, 215, 0, 1),
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
            ),
            home: const ScreenHome(),
          );
        },
      ),
    );
  }
}
