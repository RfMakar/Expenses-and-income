import 'package:budget/const/snack_bar.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/add_operation/provider_dialog_add_operation.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/widget/buttons_date_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddOperation extends StatelessWidget {
  const DialogAddOperation({super.key, required this.subCategory});
  final SubCategory subCategory;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddOperation(subCategory),
      child: Consumer<ProviderDialogAddOperation>(
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
                  final validate = provider.onPressedButtonAddCategory();

                  if (validate) {
                    Navigator.pop(context, validate);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBarApp.snackBarAdd);
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
