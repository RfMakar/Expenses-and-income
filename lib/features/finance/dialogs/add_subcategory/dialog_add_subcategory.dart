import 'package:budget/const/actions_update.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/finance/dialogs/add_subcategory/model_dialog_add_subcategories.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          validator: ValidatorTextField.text,
          decoration: const InputDecoration(
            hintText: 'Новая подкатегория',
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Добавить'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final nameSubCategory = _textEditingControllerName.text.trim();
              model.onPressedButtonAddSubCategory(nameSubCategory);
              Navigator.pop(context, StateUpdate.widget);
            }
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
