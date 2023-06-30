import 'package:budget/dialogs/edit_name/provider_dialog_edit_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
            content: Form(
              key: provider.formKey,
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 30,
                controller: provider.textEditingControllerName,
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.minLength(
                  1,
                  errorText: 'Введите название',
                ),
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
