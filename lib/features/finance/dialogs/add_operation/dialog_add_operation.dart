import 'package:budget/const/snack_bar.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/finance/dialogs/add_operation/model_dialog_add_operation.dart';
import 'package:budget/features/finance/widgets/buttons_date_time.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddOperation extends StatelessWidget {
  const DialogAddOperation({super.key, required this.subCategory});
  final SubCategory subCategory;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelDialogAddOperation(subCategory),
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
  final _textEditingControllerValue = TextEditingController();
  final _textEditingControllerNote = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _textEditingControllerNote.dispose();
    _textEditingControllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelDialogAddOperation>();
    return AlertDialog(
      title: Center(child: Text(model.titleDialog())),
      content: Form(
        key: _formKey,
        child: Wrap(
          children: [
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: _textEditingControllerValue,
              autovalidateMode: AutovalidateMode.always,
              validator: ValidatorTextField.value,
              decoration: const InputDecoration(
                hintText: 'Значение',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: _textEditingControllerNote,
              autovalidateMode: AutovalidateMode.always,
              validator: ValidatorTextField.textNote,
              decoration: const InputDecoration(
                hintText: 'Заметка',
                suffixIcon: Icon(Icons.comment),
              ),
            ),
            WidgetButtonsDateTime(
              dateTime: model.dateTime(),
              onChangedDateTime: model.onChangedDate,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Добавить'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final note = _textEditingControllerNote.text.trim();
              final value =
                  double.parse(_textEditingControllerValue.text.trim());
              model.onPressedButtonAddOperation(note, value);
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarApp.snackBarAdd);
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
