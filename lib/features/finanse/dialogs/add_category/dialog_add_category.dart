import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/finanse/dialogs/add_category/provider_dialog_add_category.dart';
import 'package:budget/features/finanse/sheets/colors/sheet_colors.dart';
import 'package:budget/provider_app.dart';
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
            title: Center(child: Text(provider.titleDialog())),
            content: Form(
              key: provider.formKey,
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: provider.textEditingControllerName,
                autovalidateMode: AutovalidateMode.always,
                validator: ValidatorTextField.text,
                decoration: InputDecoration(
                  hintText: 'Новая категория',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.brush, color: provider.colorDialog),
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
