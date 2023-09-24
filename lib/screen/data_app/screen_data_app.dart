import 'package:budget/dialogs/data_storage/dialog_data_storage.dart';
import 'package:budget/screen/data_app/provider_screen_data_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dialogs/delete/dialog_delete.dart';

class ScreenDataApp extends StatelessWidget {
  const ScreenDataApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenDataApp(),
      builder: (context, child) => Consumer<ProviderScreenDataApp>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Данные'),
            ),
            body: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud_outlined),
                  title: const Text('Хранение данных'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const DialogDataStorage(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Удалить расходы'),
                  onTap: () async {
                    final bool? result = await showDialog(
                      context: context,
                      builder: (context) => const DialodgDelete(),
                    );
                    if (result == true) {
                      provider.onTapDeleteExpenses();
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Удалить доходы'),
                  onTap: () async {
                    final bool? result = await showDialog(
                      context: context,
                      builder: (context) => const DialodgDelete(),
                    );
                    if (result == true) {
                      provider.onTapDeleteIncome();
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  textColor: Colors.red,
                  title: const Text(
                    'Удалить все данные',
                  ),
                  onTap: () async {
                    final bool? result = await showDialog(
                      context: context,
                      builder: (context) => const DialodgDelete(),
                    );
                    if (result == true) {}
                    provider.onTapDeleteAllData();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
