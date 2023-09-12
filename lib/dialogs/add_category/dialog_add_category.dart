import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/add_category/provider_dialog_add_category.dart';
import 'package:budget/sheets/colors/sheet_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddCategory extends StatelessWidget {
  const DialogAddCategory({super.key, required this.idfinance});
  final int idfinance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddCategory(idfinance),
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
                    color: provider.colorDialog,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0.5, 0.5), // Shadow position
                      ),
                    ],
                  ),
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
