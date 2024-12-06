import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/app/pages/home/page_home.dart';
import 'package:budget/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageMaterialApp extends StatelessWidget {
  const PageMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMaterialApp(),
      child: Consumer<ModelMaterialApp>(
        builder: (context, model, child) {
          return MaterialApp(
            locale: const Locale('ru'),
            onGenerateTitle: (context) => AppLocalizations.of(context)!.finance,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FormBuilderLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
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
