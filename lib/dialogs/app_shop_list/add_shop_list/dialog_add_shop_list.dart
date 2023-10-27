import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/app_shop_list/add_shop_list/provider_dialog_add_shop_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddShopList extends StatelessWidget {
  const DialogAddShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddShopList(),
      child: Consumer<ProviderDialogAddShopList>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: const Center(child: Text('Список')),
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
                  hintText: 'Новый список',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Добавить'),
                onPressed: () {
                  final validate = provider.onPressedButtonAddShopList();

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
