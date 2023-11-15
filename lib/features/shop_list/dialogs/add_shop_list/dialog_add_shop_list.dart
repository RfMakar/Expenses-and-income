import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/const/validator_text_field.dart';
import 'package:budget/features/shop_list/dialogs/add_shop_list/bloc/dialog_add_shop_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogAddShopList extends StatelessWidget {
  const DialogAddShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DialogAddShopListBloc(),
        child: BlocListener<DialogAddShopListBloc, DialogAddShopListState>(
          listener: (context, state) {
            if (state is DialogAddShopListAddState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is DialogAddShopListCancelState) {
              Navigator.pop(context);
            }
          },
          child: const DialogView(),
        ));
  }
}

class DialogView extends StatelessWidget {
  const DialogView({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingControllerName = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
              bloc.add(DialogAddShopListOnPressedButtonAddEvent(
                  nameShopList: nameShopList));
            }
          },
        ),
        TextButton(
          onPressed: () =>
              bloc.add(DialogAddShopListOnPressedButtonCancelEvent()),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
