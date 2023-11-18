import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetButtonCancel extends StatelessWidget {
  const WidgetButtonCancel({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: () => Navigator.pop(context, null),
      child: Text(localeApp.cancel),
    );
  }
}
