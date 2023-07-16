//Сумма операций
class SumOperations {
  final double value;

  SumOperations({
    required this.value,
  });

  //Чтение БД
  factory SumOperations.fromMap(Map<String, dynamic> json) => SumOperations(
        value: json['value'],
      );
}
