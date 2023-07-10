import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/add_categories/provider_dialog_add_categories.dart';
import 'package:budget/sheets/colors/sheet_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddCategories extends StatelessWidget {
  const DialogAddCategories({super.key, required this.idfinance});
  final int idfinance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddCategories(idfinance),
      child: Consumer<ProviderDialogAddCategories>(
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
                  final validate = provider.onPressedButtonAddCategories();

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
