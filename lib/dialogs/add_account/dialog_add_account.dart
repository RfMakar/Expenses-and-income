import 'package:budget/dialogs/add_account/provider_dialog_add_account.dart';
import 'package:budget/sheets/colors/sheet_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DialogAddAccount extends StatelessWidget {
  const DialogAddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddAccount(),
      child: Consumer<ProviderDialogAddAccount>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                ),
                Text(
                  'Счет',
                  style: TextStyle(color: provider.colorDialog),
                ),
                IconButton(
                    onPressed: () async {
                      final Color? color = await showModalBottomSheet(
                        context: context,
                        builder: (context) => const SheetColors(),
                      );
                      if (color != null) {
                        provider.updateColorDialog(color);
                      }
                    },
                    icon: Icon(
                      Icons.format_color_fill,
                      color: provider.colorDialog,
                    ))
              ],
            ),
            content: Form(
              key: provider.formKey,
              child: Wrap(
                children: [
                  TextFormField(
                    autofocus: true,
                    cursorColor: provider.colorDialog,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 30,
                    controller: provider.textEditingControllerName,
                    autovalidateMode: AutovalidateMode.always,
                    validator: FormBuilderValidators.minLength(
                      1,
                      errorText: 'Введите название',
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.colorDialog),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.colorDialog),
                      ),
                      labelStyle: TextStyle(color: provider.colorDialog),
                      counterStyle: TextStyle(color: provider.colorDialog),
                      labelText: 'Название',
                    ),
                  ),
                  TextFormField(
                    cursorColor: provider.colorDialog,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 10,
                    controller: provider.textEditingControllerValue,
                    autovalidateMode: AutovalidateMode.always,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(
                        1,
                        errorText: 'Введите значение',
                      ),
                      FormBuilderValidators.numeric(
                          errorText: 'Неверное значение'),
                    ]),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.colorDialog),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.colorDialog),
                      ),
                      labelStyle: TextStyle(color: provider.colorDialog),
                      counterStyle: TextStyle(color: provider.colorDialog),
                      labelText: 'Значение',
                      suffixIcon: Icon(
                        Icons.currency_ruble,
                        color: provider.colorDialog,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Добавить',
                  style: TextStyle(color: provider.colorDialog),
                ),
                onPressed: () {
                  final validate = provider.onPressedButtonAddAccount();

                  if (validate) {
                    Navigator.pop(context, validate);
                  }
                },
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Отмена',
                  style: TextStyle(color: provider.colorDialog),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
