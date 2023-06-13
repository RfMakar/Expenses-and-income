import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SwitchDate extends StatefulWidget {
  const SwitchDate(
      {super.key, required this.onPressedCallBack, required this.titleValue});

  final void Function(List<bool>, DateTime) onPressedCallBack;
  final String titleValue;

  @override
  State<SwitchDate> createState() => _SwitchDateState();
}

class _SwitchDateState extends State<SwitchDate> {
  final List<bool> isSelected = [false, true, false];
  final currentDate = DateTime.now(); // Для onPressedButtonDateNext
  var dateTime = DateTime.now(); //Текущая дата

  String getDay() {
    //Если выбрана кнопка день, то вернуть текущий день
    if (isSelected[0]) {
      return DateFormat.d().format(dateTime);
    } else {
      return 'День';
    }
  }

  String getMonth() {
    //Если выбрана кнопка месяц, то вернуть текущий месяц
    if (isSelected[0] || isSelected[1]) {
      return DateFormat.MMMM().format(dateTime);
    } else {
      return 'Месяц';
    }
  }

  String getYear() {
    //Возврат текущего года
    return DateFormat.y().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.6 / 3.0);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: Colors.blue, blurRadius: 2, offset: Offset(1, 1)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            splashRadius: 10,
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              //В зависимости он нажатой ToggleButtons изменяется число, месяц или год
              if (isSelected[0]) {
                //Если число, месяц и год не 01.01.2021(Минимальная дата в проекте) то дата переключится на день назад
                var enabledButton = (dateTime.year == 2021) &&
                    (dateTime.month == 1) &&
                    (dateTime.day == 1);
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day - 1,
                  );
                }
              } else if (isSelected[1]) {
                //Если месяц и год не 01.2021 то дата переключится на месяц назад
                var enabledButton =
                    (dateTime.year == 2021) && (dateTime.month == 1);
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month - 1,
                  );
                }
              } else if (isSelected[2]) {
                //Если год не 2021 то дата переключится на год назад
                var enabledButton = dateTime.year == 2021;
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year - 1,
                  );
                }
              }
              setState(() {
                widget.onPressedCallBack(isSelected, dateTime);
              });
            },
          ),
          Column(
            children: [
              ToggleButtons(
                constraints:
                    BoxConstraints(maxHeight: 30, minWidth: widthToggle),
                isSelected: isSelected,
                onPressed: (index) {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (index == i) {
                      isSelected[i] = true;
                    } else {
                      isSelected[i] = false;
                    }
                  }
                  setState(() {
                    //Устанавливает текущию дату после переключения ToggleButtons
                    dateTime = DateTime.now();
                    widget.onPressedCallBack(isSelected, dateTime);
                  });
                },
                children: [
                  Center(child: Text(getDay())),
                  Center(child: Text(getMonth())),
                  Center(child: Text(getYear())),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.titleValue,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Icon(Icons.currency_ruble),
                ],
              ),
            ],
          ),
          IconButton(
            splashRadius: 10,
            onPressed: () {
              //В зависимости он нажатой ToggleButtons изменяется число, месяц или год
              if (isSelected[0]) {
                //Если дата не текущая то прибавить день
                var enabledButton = (dateTime.year == currentDate.year) &&
                    (dateTime.month == currentDate.month) &&
                    (dateTime.day == currentDate.day);
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day + 1,
                  );
                }
              } else if (isSelected[1]) {
                //Если дата не текущая то прибавить месяц
                var enabledButton = (dateTime.year == currentDate.year) &&
                    (dateTime.month == currentDate.month);
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year,
                    dateTime.month + 1,
                  );
                }
              } else if (isSelected[2]) {
                //Если дата не текущая то прибавить год
                var enabledButton = dateTime.year == currentDate.year;
                if (!enabledButton) {
                  dateTime = DateTime(
                    dateTime.year + 1,
                  );
                }
              }

              setState(() {
                widget.onPressedCallBack(isSelected, dateTime);
              });
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
