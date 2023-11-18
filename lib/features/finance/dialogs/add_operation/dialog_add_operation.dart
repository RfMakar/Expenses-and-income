import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:budget/features/app/widgets/snack_bar.dart';
import 'package:budget/features/finance/dialogs/add_operation/model_dialog_add_operation.dart';
import 'package:budget/features/finance/widgets/buttons_date_time.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeApp = AppLocalizations.of(context)!;
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
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.numeric(
                  errorText: localeApp.invalidValue,
                ),
                FormBuilderValidators.minLength(
                  1,
                  errorText: localeApp.enterAValue,
                ),
                FormBuilderValidators.maxLength(
                  10,
                  errorText: localeApp.invalidValue,
                ),
                FormBuilderValidators.min(
                  0,
                  errorText: localeApp.invalidValue,
                ),
              ]),
              decoration: InputDecoration(
                hintText: localeApp.enterAValue,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: _textEditingControllerNote,
              autovalidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.maxLength(
                50,
                errorText: localeApp.longValue,
              ),
              decoration: InputDecoration(
                hintText: localeApp.note,
                suffixIcon: const Icon(Icons.comment),
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
        const WidgetButtonCancel(),
        TextButton(
          child: Text(localeApp.add),
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
      ],
    );
  }
}
