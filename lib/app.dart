import 'package:budget/provider_app.dart';
import 'package:budget/screens/home/screen_home.dart';
import 'package:budget/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

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
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: themeMode,
            home: const ScreenHome(),
          );
        },
      ),
    );
  }
}
