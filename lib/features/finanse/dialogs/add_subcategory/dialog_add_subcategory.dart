import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/finanse/dialogs/add_subcategory/provider_dialog_add_subcategories.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddSubCategory extends StatelessWidget {
  const DialogAddSubCategory({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddSubCategory(category),
      child: Consumer<ProviderDialogAddSubCategory>(
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
