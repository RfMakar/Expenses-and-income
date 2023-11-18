import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SheetSelectPeriod extends StatelessWidget {
  const SheetSelectPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final modelApp = Provider.of<ModelMaterialApp>(context);
    final stateApp = modelApp.switchDate.state;
    return Wrap(
      children: [
        ListTile(
            title: Text(
          localeApp.selectAPeriod,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        ListTile(
          title: Text(localeApp.month),
          trailing: stateApp == 0 ? const Icon(Icons.check) : null,
          onTap: () {
            if (stateApp == 1) {
              Navigator.pop(context, StateUpdate.page);
              modelApp.switchDate.switchState();
            }
          },
        ),
        ListTile(
          title: Text(localeApp.year),
          trailing: stateApp == 1 ? const Icon(Icons.check) : null,
          onTap: () {
            if (stateApp == 0) {
              Navigator.pop(context, StateUpdate.page);
              modelApp.switchDate.switchState();
            }
          },
        ),
      ],
    );
  }
}
