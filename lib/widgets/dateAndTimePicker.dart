part of widgets;

///Pick a Date & Time for [note.reminder].
class DateAndTimePicker extends StatefulWidget {
  final Note note;
  final TextEditingController controller;

  DateAndTimePicker(
    this.note, {
    Key key,
    TextEditingController controller,
  })  : assert(note != null),
        this.controller = controller ?? TextEditingController(),
        super(key: key);

  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.note.getReminder ?? DateTime.now();
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

    widget.note.reminder = selectedDate.toString();

    setState(() {
      widget.controller.text = widget.note.getFormatedDate;
    });
  }

  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: widget.controller,
      onTap: showDateThanTime,
      decoration: InputDecoration(
        labelText: 'Remind me at',
        suffixIcon: const Icon(Icons.date_range),
      ),
    );
  }
}
