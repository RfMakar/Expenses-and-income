import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          label: Text(DateFormat.yMMMd().format(DateTime.now())),
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
        TextButton.icon(
          label: Text(timeOfDay.format(context)),
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
      ],
    );
  }
}
