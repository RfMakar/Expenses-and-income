import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/app/pages/home/page_home.dart';
import 'package:budget/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class PageMaterialApp extends StatelessWidget {
  const PageMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMaterialApp(),
      child: Consumer<ModelMaterialApp>(
        builder: (context, model, child) {
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
            home: const PageHome(),
          );
        },
      ),
    );
  }
}
