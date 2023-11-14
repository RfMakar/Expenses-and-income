import 'package:budget/const/actions_update.dart';
import 'package:budget/const/validator_text_field.dart';
import 'package:budget/features/finanse/dialogs/add_category/model_dialog_add_category.dart';
import 'package:budget/features/finanse/sheets/colors/sheet_colors.dart';
import 'package:budget/model_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddCategory extends StatelessWidget {
  const DialogAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = context.read<ModelApp>();
    return ChangeNotifierProvider(
      create: (context) => ModelDialogAddCategory(modelApp.finance),
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
  final _textEditingControllerName = TextEditingController();

  @override
  void dispose() {
    _textEditingControllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelDialogAddCategory>();
    return AlertDialog(
      title: Center(child: Text(model.titleDialog())),
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
            hintText: 'Новая категория',
            suffixIcon: IconButtomUpdateColor(),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Добавить'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              model.onPressedButtonAddCategory(
                  _textEditingControllerName.text.trim());
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

class IconButtomUpdateColor extends StatelessWidget {
  const IconButtomUpdateColor({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelDialogAddCategory>();
    return IconButton(
      icon: Icon(Icons.brush, color: model.colorIconDialog()),
      onPressed: () async {
        final Color? color = await showModalBottomSheet(
          context: context,
          builder: (context) => const SheetColors(),
        );
        if (color != null) {
          model.updateColor(color);
        }
      },
    );
  }
}
