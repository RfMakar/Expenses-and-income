import 'package:budget/features/app/widgets/snack_bar.dart';
import 'package:budget/features/app/const/validator_text_field.dart';

import 'package:flutter/material.dart';

class DialogEditName extends StatefulWidget {
  const DialogEditName({super.key, required this.nameEdit});
  final String nameEdit;

  @override
  State<DialogEditName> createState() => _DialogEditNameState();
}

class _DialogEditNameState extends State<DialogEditName> {
  late String nameEdit;
  final _formKey = GlobalKey<FormState>();
  final _textEditingControllerName = TextEditingController();
  @override
  void initState() {
    nameEdit = widget.nameEdit;
    _textEditingControllerName.text = widget.nameEdit;
    _textEditingControllerName.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textEditingControllerName.text.length,
    );
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Переименовать')),
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
            hintText: 'Новое название',
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Сохранить'),
          onPressed: () {
            final newName = _textEditingControllerName.text.trim();
            if (_formKey.currentState!.validate() & (nameEdit != newName)) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarApp.snackBarEdit);
              Navigator.pop(context, newName);
            }
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
