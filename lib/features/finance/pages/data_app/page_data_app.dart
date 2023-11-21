import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
//import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/finance/dialogs/data_storage/dialog_data_storage.dart';
import 'package:budget/features/finance/pages/data_app/model_page_data_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeApp = AppLocalizations.of(context)!;
    //final modelApp = Provider.of<ModelMaterialApp>(context);
    final model = context.read<ModelPageDataApp>();
    return Scaffold(
      appBar: AppBar(
        title: Text(localeApp.data),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: Text(localeApp.dataStorage),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const DialogDataStorage(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(localeApp.deleteAllTransactions),
            onTap: () async {
              final bool? result = await showDialog(
                context: context,
                builder: (context) => const DialodgDelete(),
              );
              if (result == true) {
                model.onTapDeleteAllOperation();
                //modelApp.updateApp();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            textColor: Colors.red,
            title: Text(localeApp.deleteAllData),
            onTap: () async {
              final bool? result = await showDialog(
                context: context,
                builder: (context) => const DialodgDelete(),
              );
              if (result == true) {
                model.onTapDeleteAll();
                //modelApp.updateApp();
              }
            },
          ),
        ],
      ),
    );
  }
}
