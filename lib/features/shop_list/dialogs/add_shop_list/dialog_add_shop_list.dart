import 'package:budget/const/actions_update.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/shop_list/dialogs/add_shop_list/bloc/dialog_add_shop_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogAddShopList extends StatelessWidget {
  const DialogAddShopList({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingControllerName = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => DialogAddShopListBloc(),
      child: Builder(builder: (context) {
        final bloc = BlocProvider.of<DialogAddShopListBloc>(context);
        return AlertDialog(
          title: const Center(child: Text('Список')),
          content: Form(
            key: formKey,
            child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: textEditingControllerName,
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
                if (!formKey.currentState!.validate()) {
                  return;
                } else {
                  final nameShopList = textEditingControllerName.text.trim();
                  bloc.add(DialogAddShopListInsertDBEvent(
                      nameShopList: nameShopList));
                  Navigator.pop(context, StateUpdate.page);
                }
                // final validate = provider.onPressedButtonAddShopList();

                // if (validate) {
                //   Navigator.pop(context, StateUpdate.page);
                // }
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      }),
    );
  }
}
