import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/widgets/snack_bar.dart';
import 'package:budget/features/app/const/validator_text_field.dart';
import 'package:budget/features/finance/dialogs/edit_operation/model_dialog_edit_operation.dart';
import 'package:budget/features/finance/widgets/buttons_date_time.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogEditOperation extends StatelessWidget {
  const DialogEditOperation({super.key, required this.operation});
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelDialogEditOperation(operation),
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
  final _formKey = GlobalKey<FormState>();
  final _textEditingControllerValue = TextEditingController();
  final _textEditingControllerNote = TextEditingController();

  @override
  void dispose() {
    _textEditingControllerValue.dispose();
    _textEditingControllerNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelDialogEditOperation>();
    _textEditingControllerValue.text = model.value();
    _textEditingControllerNote.text = model.note();
    _textEditingControllerValue.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textEditingControllerValue.text.length,
    );
    return AlertDialog(
      title: const Center(child: Text('Изменить')),
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
          )),
      actions: [
        TextButton(
          child: const Text('Изменить'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newValue =
                  double.parse(_textEditingControllerValue.text.trim());
              final newNote = _textEditingControllerNote.text.trim();
              model.onPressedButtonEditOperation(newValue, newNote);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarApp.snackBarEdit);
              Navigator.pop(context, StateUpdate.page);
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
