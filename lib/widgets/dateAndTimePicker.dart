import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:NotesAndGoals/tools/note.dart';

///Pick a Date & Time for [note.reminder].
class DateAndTimePicker extends StatefulWidget {
  final Note note;

  const DateAndTimePicker(this.note, {Key key})
      : assert(note != null),
        super(key: key);

  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  final controller = TextEditingController();

  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.tryParse(widget.note.reminder) ?? DateTime.now();
  }

  Future<void> showDateThanTime() async {
    //If the user click the cancel button , the value of [tempDate] will be [null].
    final DateTime tempDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    //If the user click the cancel button , the value of [tempTime] will be [null].
    TimeOfDay tempTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: selectedDate.hour,
        minute: selectedDate.minute,
      ),
    );

    tempTime ??=
        TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);

    if (tempDate != null) selectedDate = tempDate;

    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      tempTime.hour,
      tempTime.minute,
    );

    controller.text = DateFormat('y/MMM/d').format(selectedDate) +
        ' , ' +
        DateFormat.jm().format(selectedDate);

    widget.note.reminder = selectedDate.toString();
  }

  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: controller,
      onTap: showDateThanTime,
      decoration: InputDecoration(
        labelText: 'Remind me at',
        suffixIcon: const Icon(Icons.date_range),
      ),
    );
  }
}
