import 'package:budget/const/validator_text_field.dart';
import 'package:budget/dialogs/app_shop_list/add_record_list/provider_dialog_add_record_list.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddRecordList extends StatelessWidget {
  const DialogAddRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddRecordList(shopList),
      child: Consumer<ProviderDialogAddRecordList>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Center(child: Text(shopList.name)),
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
                  hintText: 'Новая запись',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Добавить'),
                onPressed: () {
                  final validate = provider.onPressedButtonAddRecordList();

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
