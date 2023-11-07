import 'package:budget/const/actions_update.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/shop_list/dialogs/add_record_list/bloc/dialog_add_record_list_bloc.dart';
import 'package:budget/features/shop_list/dialogs/add_shop_list/bloc/dialog_add_shop_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogAddRecordList extends StatelessWidget {
  const DialogAddRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DialogAddRecordListBloc(shopList),
        child: BlocListener<DialogAddRecordListBloc, DialogAddRecordListState>(
          listener: (context, state) {
            if (state is DialogAddRecordListAddState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is DialogAddRecordListCancelState) {
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
    final bloc = BlocProvider.of<DialogAddRecordListBloc>(context);
    return AlertDialog(
      title: const NameDialog(),
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
            hintText: 'Новая запись',
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
              final nameRecordList = textEditingControllerName.text.trim();
              bloc.add(DialogAddRecordListAddEvent(nameRecordList));
            }
          },
        ),
        TextButton(
          onPressed: () => bloc.add(DialogAddRecordListCancelEvent()),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}

class NameDialog extends StatelessWidget {
  const NameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogAddRecordListBloc, DialogAddRecordListState>(
      builder: (context, state) {
        if (state is DialogAddRecordListInitial) {
          return Center(child: Text(state.shopList.name));
        } else {
          return const Text('');
        }
      },
    );
  }
}
