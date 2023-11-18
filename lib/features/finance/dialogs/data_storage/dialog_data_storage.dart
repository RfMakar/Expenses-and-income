import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogDataStorage extends StatelessWidget {
  const DialogDataStorage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Center(
        child: Text(localeApp.dataStorage),
      ),
      content: Text(localeApp.descriptionOfDataStorage),
      actions: const [WidgetButtonCancel()],
    );
  }
}
