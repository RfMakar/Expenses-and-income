import 'package:budget/features/app/pages/material_app/model_material_app.dart';
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
    final providerApp = Provider.of<ModelMaterialApp>(context);
    return Provider(
      create: (context) => ModelSheetOperation(operation, providerApp.finance),
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
            model.titleSheet(),
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
            localeApp.note,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
