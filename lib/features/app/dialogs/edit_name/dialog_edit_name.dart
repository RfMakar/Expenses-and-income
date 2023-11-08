import 'package:budget/const/snack_bar.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/app/dialogs/edit_name/provider_dialog_edit_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogEditName extends StatelessWidget {
  const DialogEditName({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogEditName(name),
      child: Consumer<ProviderDialogEditName>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: const Center(child: Text('Переименовать')),
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
                  hintText: 'Новое название',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Сохранить'),
                onPressed: () {
                  final newName = provider.onPressedButtonSave();

                  if (newName != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBarApp.snackBarEdit);
                    Navigator.pop(context, newName);
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: const Text('Отмена'),
              ),
            ],
          );
        },
      ),
    );
  }
}
