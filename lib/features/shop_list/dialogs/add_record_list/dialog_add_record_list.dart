import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';

class DialogAddRecordList extends StatelessWidget {
  const DialogAddRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*

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
                    Navigator.pop(context, StateUpdate.page);
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

class ProviderDialogAddRecordList extends ChangeNotifier {
  final ShopList shopList;
  ProviderDialogAddRecordList(this.shopList);
  final textEditingControllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddRecordList() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBRecordList();
      return true;
    }
  }

  void insertDBRecordList() {
    final writeRecordList = WriteRecordList(
      name: textEditingControllerName.text.trim(),
      idshoplist: shopList.id,
      isselected: 0,
    );
    DBShopList.insertRecordList(writeRecordList);
  }
}

*/