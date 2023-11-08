import 'package:budget/features/finanse/sheets/operation/provider_sheet_operation.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetOperation extends StatelessWidget {
  const SheetOperation({super.key, required this.operation});
  final Operation operation;

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderSheetOperation(operation, providerApp.finance.id),
      child: Consumer<ProviderSheetOperation>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              Center(
                child: Text(
                  provider.titleSheet(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const Divider(),
              Center(
                child: Text(
                  provider.subtitleSheet(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              ListTile(
                title: Text(provider.titleCategoty()),
                subtitle: const Text(
                  'Категория',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              ListTile(
                title: Text(provider.titleSubCategory()),
                subtitle: const Text(
                  'Подкатегория',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              ListTile(
                title: Text(provider.titleNote()),
                subtitle: const Text(
                  'Заметка',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
