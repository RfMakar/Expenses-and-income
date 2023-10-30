import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/app_finance/add_category/provider_dialog_add_category.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/sheets/app_finance/colors/sheet_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddCategory extends StatelessWidget {
  const DialogAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddCategory(providerApp.finance),
      child: Consumer<ProviderDialogAddCategory>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 40),
                Text(provider.titleDialog()),
                Container(
                  decoration: BoxDecoration(
                      color: provider.colorDialog, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.brush, color: Colors.white),
                    onPressed: () async {
                      final Color? color = await showModalBottomSheet(
                        context: context,
                        builder: (context) => const SheetColors(),
                      );
                      if (color != null) {
                        provider.updateColorDialog(color);
                      }
                    },
                  ),
                ),
              ],
            ),
            content: Form(
              key: provider.formKey,
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: provider.textEditingControllerName,
                autovalidateMode: AutovalidateMode.always,
                validator: ValidatorTextField.text,
                decoration: const InputDecoration(
                  hintText: 'Новая категория',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Добавить'),
                onPressed: () {
                  final validate = provider.onPressedButtonAddCategory();

                  if (validate) {
                    Navigator.pop(context, validate);
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Отмена'),
              ),
            ],
          );
        },
      ),
    );
  }
}