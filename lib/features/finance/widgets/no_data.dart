import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetNoData extends StatelessWidget {
  const WidgetNoData({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(localeApp.noData),
    ));
  }
}
