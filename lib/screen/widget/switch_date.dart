import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
Виджет переключает дату (месяц и год) и возрашает дату
*/

class SwitchDate extends StatefulWidget {
  const SwitchDate(
      {super.key,
      required this.onPressedCallBack,
      required this.dateTime,
      required this.value});

  final void Function(DateTime) onPressedCallBack;
  final DateTime dateTime;
  final String value;
  @override
  State<SwitchDate> createState() => _SwitchDateState();
}

class _SwitchDateState extends State<SwitchDate> {
  final currentDate = DateTime.now(); // Для onPressedButtonDateNext
  late DateTime dateTime; //Текущая дата

  String getDate() {
    return DateFormat.yMMMM().format(dateTime);
  }

  @override
  void initState() {
    dateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                widget.value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      //Если месяц и год не 01.2021 то дата переключится на месяц назад
                      var enabledButton =
                          (dateTime.year == 2021) && (dateTime.month == 1);
                      if (!enabledButton) {
                        dateTime = DateTime(
                          dateTime.year,
                          dateTime.month - 1,
                        );
                      }
                      setState(() {
                        widget.onPressedCallBack(dateTime);
                      });
                    },
                  ),
                  Text(
                    getDate(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {
                      //Если дата не текущая то прибавить месяц
                      var enabledButton = (dateTime.year == currentDate.year) &&
                          (dateTime.month == currentDate.month);
                      if (!enabledButton) {
                        dateTime = DateTime(
                          dateTime.year,
                          dateTime.month + 1,
                        );
                      }

                      setState(() {
                        widget.onPressedCallBack(dateTime);
                      });
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: IconButton(
              color: Colors.grey,
              onPressed: () {},
              icon: const Icon(Icons.date_range_outlined),
              iconSize: 30,
            ),
          )
        ],
      ),
    );
  }
}
