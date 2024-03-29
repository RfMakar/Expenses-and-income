import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:budget/features/app/widgets/snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
    final localeApp = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Center(child: Text(localeApp.rename)),
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
            hintText: localeApp.newTitle,
          ),
        ),
      ),
      actions: [
        const WidgetButtonCancel(),
        TextButton(
          child: Text(
            localeApp.save,
          ),
          onPressed: () {
            final newName = _textEditingControllerName.text.trim();
            if (_formKey.currentState!.validate() & (nameEdit != newName)) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarApp.snackBarEdit);
              Navigator.pop(context, newName);
            }
          },
        ),
      ],
    );
  }
}
