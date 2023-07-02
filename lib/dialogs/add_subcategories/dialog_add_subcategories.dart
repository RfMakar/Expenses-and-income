import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/add_subcategories/provider_dialog_add_subcategories.dart';
import 'package:budget/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddSubCategories extends StatelessWidget {
  const DialogAddSubCategories({super.key, required this.categories});
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddSubCategories(categories),
      child: Consumer<ProviderDialogAddSubCategories>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Center(
              child: Text(provider.titleDialog()),
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
                  hintText: 'Новая подкатегория',
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
