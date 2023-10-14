import 'package:budget/provider_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetSelectPeriod extends StatelessWidget {
  const SheetSelectPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);

    return Wrap(
      children: [
        const ListTile(
            title: Text(
          'Выберите период',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        const Divider(),
        ListTile(
          title: const Text('Год'),
          onTap: () {
            Navigator.pop(context);
            providerApp.switchDate.stateYear();
            providerApp.updateApp();
          },
        ),
        ListTile(
          title: const Text('Месяц'),
          onTap: () {
            Navigator.pop(context);
            providerApp.switchDate.stateMonth();
            providerApp.updateApp();
          },
        ),
      ],
    );
  }
}
