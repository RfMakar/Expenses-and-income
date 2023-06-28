import 'package:budget/dialogs/add_subcategories/provider_dialod_add_subcategories.dart';
import 'package:budget/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DialogAddSubCategories extends StatelessWidget {
  const DialogAddSubCategories({super.key, required this.categories});
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDialogAddSubCategories(categories),
      child: Consumer<ProviderDialogAddSubCategories>(
        builder: (context, provider, child) {
          return AlertDialog(
            title: Center(
              child: Text(
                provider.titleDialog(),
                style: TextStyle(color: provider.colorDialog()),
              ),
            ),
            content: Form(
              key: provider.formKey,
              child: Wrap(
                children: [
                  TextFormField(
                    autofocus: true,
                    cursorColor: provider.colorDialog(),
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
                        borderSide: BorderSide(color: provider.colorDialog()),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.colorDialog()),
                      ),
                      labelStyle: TextStyle(color: provider.colorDialog()),
                      counterStyle: TextStyle(color: provider.colorDialog()),
                      labelText: 'Название подкатегории',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Добавить',
                  style: TextStyle(color: provider.colorDialog()),
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
                  style: TextStyle(color: provider.colorDialog()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
