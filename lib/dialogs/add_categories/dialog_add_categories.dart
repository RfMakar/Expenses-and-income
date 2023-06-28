import 'package:budget/dialogs/add_categories/provider_dialog_add_categories.dart';
import 'package:budget/screen2/widget/selected_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DialogAddCategories extends StatelessWidget {
  const DialogAddCategories({super.key, required this.idoperations});
  final int idoperations;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddCategories(idoperations),
      child: Consumer<ProviderDialogAddCategories>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                ),
                Text(
                  provider.titleDialog(),
                  style: TextStyle(color: provider.colorDialog),
                ),
                IconButton(
                    onPressed: () async {
                      final Color? color = await showModalBottomSheet(
                        context: context,
                        builder: (context) => const WidgetSelectedColor(),
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
                      labelText: 'Название категории',
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
                  final validate = provider.onPressedButtonAddCategories();

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
