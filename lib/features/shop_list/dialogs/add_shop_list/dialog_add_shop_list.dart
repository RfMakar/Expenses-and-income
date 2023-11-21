import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/shop_list/dialogs/add_shop_list/bloc/dialog_add_shop_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeApp = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<DialogAddShopListBloc>(context);
    return AlertDialog(
      title: Center(child: Text(localeApp.list)),
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
              errorText: localeApp.enterTheTitle,
            ),
            FormBuilderValidators.maxLength(
              50,
              errorText: localeApp.longTitle,
            ),
          ]),
          decoration: InputDecoration(
            hintText: localeApp.newList,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              bloc.add(DialogAddShopListOnPressedButtonCancelEvent()),
          child: Text(localeApp.cancel),
        ),
        TextButton(
          child: Text(localeApp.add),
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
      ],
    );
  }
}
