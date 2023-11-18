import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:budget/features/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialodgDelete extends StatelessWidget {
  const DialodgDelete({super.key});
  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Center(child: Text('${localeApp.delete} ?')),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBarApp.snackBarDelete);
                Navigator.pop(context, true);
              },
              child: Text(localeApp.delete),
            ),
            const WidgetButtonCancel(),
          ],
        ),
      ],
    );
  }
}
