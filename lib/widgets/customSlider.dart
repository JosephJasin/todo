part of widgets;

class CustomSlider extends StatefulWidget {
  final Note note;

  CustomSlider(this.note, {Key key})
      : assert(note != null),
        super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.note.priority.toDouble() ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider(
        min: 1,
        max: 5,
        divisions: 4,
        value: _value,
        onChanged: (value) => setState(() => _value = value),
        onChangeEnd: (value) => widget.note.priority = value.toInt(),
        label: '$_value',
      ),
    );
  }
}
