import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/const/validator_text_field.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/app/widgets/button_cancel.dart';
import 'package:budget/features/finance/dialogs/add_category/model_dialog_add_category.dart';
import 'package:budget/features/finance/sheets/colors/sheet_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogAddCategory extends StatelessWidget {
  const DialogAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = context.read<ModelMaterialApp>();
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
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelDialogAddCategory>();
    String titleAppBar() {
      final modelApp = context.read<ModelMaterialApp>();

      switch (modelApp.finance.id) {
        case 0:
          return localeApp.expense;
        case 1:
          return localeApp.income;
        default:
          return '';
      }
    }

    return AlertDialog(
      title: Center(child: Text(titleAppBar())),
      content: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          controller: _textEditingControllerName,
          autovalidateMode: AutovalidateMode.always,
          validator: ValidatorTextField.text,
          decoration: InputDecoration(
            hintText: localeApp.newCategory,
            suffixIcon: const IconButtomUpdateColor(),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(localeApp.add),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              model.onPressedButtonAddCategory(
                  _textEditingControllerName.text.trim());
              Navigator.pop(context, StateUpdate.page);
            }
          },
        ),
        const WidgetButtonCancel(),
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
