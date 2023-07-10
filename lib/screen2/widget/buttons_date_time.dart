import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetButtonsDateTime extends StatefulWidget {
  const WidgetButtonsDateTime({
    Key? key,
    required this.dateTime,
    required this.onChangedDateTime,
  }) : super(key: key);
  final DateTime dateTime;
  final ValueChanged<DateTime> onChangedDateTime;

  @override
  State<WidgetButtonsDateTime> createState() => _WidgetButtonsDateTimeState();
}

class _WidgetButtonsDateTimeState extends State<WidgetButtonsDateTime> {
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    var timeOfDay = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Text(DateFormat.yMMMd().format(dateTime)),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: dateTime,
              firstDate: DateTime(2021),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() {
                dateTime = dateTime.copyWith(
                  year: picked.year,
                  month: picked.month,
                  day: picked.day,
                );
              });
              widget.onChangedDateTime(dateTime);
            }
          },
        ),
        TextButton(
          child: Text(timeOfDay.format(context)),
          onPressed: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: timeOfDay,
            );
            if (picked != null) {
              setState(() {
                timeOfDay = picked;
                dateTime = dateTime.copyWith(
                    hour: timeOfDay.hour, minute: timeOfDay.minute);
                widget.onChangedDateTime(dateTime);
              });
            }
          },
        ),
      ],
    );
  }
}
