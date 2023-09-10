import 'package:form_builder_validators/form_builder_validators.dart';

class ValidatorTextField {
  static var value = FormBuilderValidators.compose([
    FormBuilderValidators.numeric(
      errorText: 'Неверное значение',
    ),
    FormBuilderValidators.minLength(
      1,
      errorText: 'Введите значение',
    ),
    FormBuilderValidators.maxLength(
      10,
      errorText: 'Неверное значение',
    ),
    FormBuilderValidators.min(
      0,
      errorText: 'Неверное значение',
    ),
  ]);
  static var text = FormBuilderValidators.compose([
    FormBuilderValidators.minLength(
      1,
      errorText: 'Введите название',
    ),
    FormBuilderValidators.maxLength(
      50,
      errorText: 'Длинное название',
    ),
  ]);
  static var textNote = FormBuilderValidators.maxLength(
    50,
    errorText: 'Длинное значение',
  );
}
