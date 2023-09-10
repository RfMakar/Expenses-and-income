import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/edit_operation/provider_dialog_edit_operation.dart';
import 'package:budget/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogEditOperation extends StatelessWidget {
  const DialogEditOperation({super.key, required this.operation});
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogEditOperation(operation),
      child: Consumer<ProviderDialogEditOperation>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: const Center(child: Text('Изменить')),
            content: Form(
                key: provider.formKey,
                child: Wrap(
                  children: [
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      controller: provider.textEditingControllerValue,
                      autovalidateMode: AutovalidateMode.always,
                      validator: ValidatorTextField.value,
                      decoration: const InputDecoration(
                        hintText: 'Значение',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: provider.textEditingControllerNote,
                      autovalidateMode: AutovalidateMode.always,
                      validator: ValidatorTextField.textNote,
                      decoration: const InputDecoration(
                        hintText: 'Заметка',
                        suffixIcon: Icon(Icons.comment),
                      ),
                    ),
                  ],
                )),
            actions: [
              TextButton(
                child: const Text('Изменить'),
                onPressed: () {
                  final validate = provider.onPressedButtonEditOperation();

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
