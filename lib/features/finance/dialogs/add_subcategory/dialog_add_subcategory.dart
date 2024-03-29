import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:budget/features/finance/dialogs/add_subcategory/model_dialog_add_subcategories.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogAddSubCategory extends StatelessWidget {
  const DialogAddSubCategory({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelDialogAddSubCategory(category),
      child: const ViewDialog(),
    );
  }
}

class ViewDialog extends StatefulWidget {
  const ViewDialog({super.key});

  @override
  State<ViewDialog> createState() => _ViewDialogState();
}

class _ViewDialogState extends State<ViewDialog> {
  final _textEditingControllerName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textEditingControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelDialogAddSubCategory>();
    return AlertDialog(
      title: Center(
        child: Text(model.titleDialog()),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: _textEditingControllerName,
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
            hintText: localeApp.newSubcategory,
          ),
        ),
      ),
      actions: [
        const WidgetButtonCancel(),
        TextButton(
          child: Text(localeApp.add),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final nameSubCategory = _textEditingControllerName.text.trim();
              model.onPressedButtonAddSubCategory(nameSubCategory);
              Navigator.pop(context, StateUpdate.widget);
            }
          },
        ),
      ],
    );
  }
}
