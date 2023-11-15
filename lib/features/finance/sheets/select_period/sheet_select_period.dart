import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetSelectPeriod extends StatelessWidget {
  const SheetSelectPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ModelMaterialApp>(context);
    final stateApp = providerApp.switchDate.state;
    return Wrap(
      children: [
        const ListTile(
            title: Text(
          'Выберите период',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        ListTile(
          title: const Text('Месяц'),
          trailing: stateApp == 0 ? const Icon(Icons.check) : null,
          onTap: () {
            if (stateApp == 1) {
              Navigator.pop(context, StateUpdate.page);
              providerApp.switchDate.switchState();
            }
          },
        ),
        ListTile(
          title: const Text('Год'),
          trailing: stateApp == 1 ? const Icon(Icons.check) : null,
          onTap: () {
            if (stateApp == 0) {
              Navigator.pop(context, StateUpdate.page);
              providerApp.switchDate.switchState();
            }
          },
        ),
      ],
    );
  }
}
