import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/add_operations/provider_dialog_add_operations.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/screen2/widget/buttons_date_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddOperations extends StatelessWidget {
  const DialogAddOperations({super.key, required this.subCategories});
  final SubCategories subCategories;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddOperations(subCategories),
      child: Consumer<ProviderDialogAddOperations>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Center(child: Text(provider.titleDialog())),
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
                      suffixIcon: Icon(Icons.currency_ruble),
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
                  WidgetButtonsDateTime(
                    dateTime: provider.dateTime,
                    onChangedDateTime: provider.onChangedDate,
                  ),
                ],
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
