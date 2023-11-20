import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/shop_list/dialogs/add_record_list/bloc/dialog_add_record_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeApp = AppLocalizations.of(context)!;
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
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(
              1,
              errorText: localeApp.enterAName,
            ),
            FormBuilderValidators.maxLength(
              50,
              errorText: localeApp.localeName,
            ),
          ]),
          decoration: InputDecoration(
            hintText: localeApp.newRecord,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => bloc.add(DialogAddRecordListCancelEvent()),
          child: Text(localeApp.cancel),
        ),
        TextButton(
          child: Text(localeApp.add),
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            } else {
              final nameRecordList = textEditingControllerName.text.trim();
              bloc.add(DialogAddRecordListAddEvent(nameRecordList));
            }
          },
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
