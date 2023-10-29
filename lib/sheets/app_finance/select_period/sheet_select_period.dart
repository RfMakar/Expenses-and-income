import 'package:budget/const/actions_update.dart';
import 'package:budget/provider_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetSelectPeriod extends StatelessWidget {
  const SheetSelectPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
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
              Navigator.pop(context, ActionsUpdate.updateScreen);
              providerApp.switchDate.stateMonth();
            }
          },
        ),
        ListTile(
          title: const Text('Год'),
          trailing: stateApp == 1 ? const Icon(Icons.check) : null,
          onTap: () {
            if (stateApp == 0) {
              Navigator.pop(context, ActionsUpdate.updateScreen);
              providerApp.switchDate.stateYear();
            }
          },
        ),
      ],
    );
  }
}
