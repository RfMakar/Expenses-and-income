import 'package:budget/features/finance/sheets/operation/model_sheet_operation.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SheetOperation extends StatelessWidget {
  const SheetOperation({super.key, required this.operation});
  final Operation operation;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelSheetOperation(operation),
      child: const ViewSheet(),
    );
  }
}

class ViewSheet extends StatelessWidget {
  const ViewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelSheetOperation>();
    return Wrap(
      children: [
        Center(
          child: Text(
            localeApp.valueFormatSimpleCurrency(model.titleSheet()),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const Divider(),
        Center(
          child: Text(
            localeApp.dateTimeFormatOperationFrom(
                model.dateTime(), model.dateTime()),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        ListTile(
          title: Text(model.titleCategoty()),
          subtitle: Text(
            localeApp.category,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(model.titleSubCategory()),
          subtitle: Text(
            localeApp.subcategory,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(model.titleNote()),
          subtitle: Text(
            localeApp.theNote,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
