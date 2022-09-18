import 'package:budget/model/date_time.dart';
import 'package:flutter/material.dart';

class ButtonsDateTime extends StatefulWidget {
  const ButtonsDateTime({
    Key? key,
    required this.dateTime,
    required this.timeOfDay,
    required this.onChangedDate,
    required this.onChangedTime,
  }) : super(key: key);
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  final ValueChanged<DateTime> onChangedDate;
  final ValueChanged<TimeOfDay> onChangedTime;

  @override
  State<ButtonsDateTime> createState() => _ButtonsDateTimeState();
}

class _ButtonsDateTimeState extends State<ButtonsDateTime> {
  late DateTime dateTime;
  late TimeOfDay timeOfDay;

  @override
  void initState() {
    super.initState();
    dateTime = widget.dateTime;
    timeOfDay = widget.timeOfDay;
  }

  @override
  Widget build(BuildContext context) {
    final nameButtonDate = FormatDateTime.getFormatDateDayMonthYear(dateTime);
    final nameButtonTime = FormatDateTime.getFormatTimeHourMinute(timeOfDay);
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: Text('Дата'))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text('Время'))),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: OutlinedButton.icon(
                  label: Text(nameButtonDate),
                  icon: const Icon(Icons.date_range),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime(2021),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => dateTime = picked);
                      widget.onChangedDate(picked);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: OutlinedButton.icon(
                  label: Text(nameButtonTime),
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: timeOfDay,
                    );
                    if (picked != null) {
                      setState(() => timeOfDay = picked);
                      widget.onChangedTime(picked);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
