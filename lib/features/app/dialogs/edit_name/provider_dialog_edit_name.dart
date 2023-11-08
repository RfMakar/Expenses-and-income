import 'package:flutter/material.dart';

class ProviderDialogEditName extends ChangeNotifier {
  ProviderDialogEditName(this.name) {
    init();
  }
  final String name;
  final formKey = GlobalKey<FormState>();
  final textEditingControllerName = TextEditingController();

  void init() {
    textEditingControllerName.text = name;
  }

  String? onPressedButtonSave() {
    if (!formKey.currentState!.validate()) {
      return null;
    } else if (name == textEditingControllerName.text.trim()) {
      return null;
    } else {
      return textEditingControllerName.text.trim();
    }
  }
}
