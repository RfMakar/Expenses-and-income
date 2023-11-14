import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/finanse/dialogs/data_storage/dialog_data_storage.dart';
import 'package:budget/features/finanse/pages/data_app/model_page_data_app.dart';
import 'package:budget/model_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageDataApp extends StatelessWidget {
  const PageDataApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelPageDataApp(),
      child: const ViewPage(),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ModelApp>(context);
    final model = context.read<ModelPageDataApp>();
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
            title: const Text(
              'Удалить все операции',
            ),
            onTap: () async {
              final bool? result = await showDialog(
                context: context,
                builder: (context) => const DialodgDelete(),
              );
              if (result == true) {
                model.onTapDeleteAllOperation();
                providerApp.updateApp();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            textColor: Colors.red,
            title: const Text('Удалить все данные'),
            onTap: () async {
              final bool? result = await showDialog(
                context: context,
                builder: (context) => const DialodgDelete(),
              );
              if (result == true) {
                model.onTapDeleteAll();
                providerApp.updateApp();
              }
            },
          ),
        ],
      ),
    );
  }
}
