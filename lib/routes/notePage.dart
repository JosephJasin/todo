part of pages;

class NotePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  NotePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, Notes builder, child) {
        return ListView.builder(
          itemCount: builder.notesLength,
          itemBuilder: (context, index) {
            return OpenContainer(
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => NoteWidget(
                builder.notes[index],
              ),
              openBuilder: (context, action) => EditNotePage(
                row: builder.notes[index],
                scaffold: scaffoldKey,
              ),
            );
          },
        );
      },
    );
  }
}

extension on int {
  bool toBool() => this == 1;
}

extension on bool {
  int toInt() => this ? 1 : 0;
}

//oldNote Widget

//class NoteWidget extends StatelessWidget {
//  final Note note;
//
//  NoteWidget(Map<String, dynamic> row, {Key key})
//      : note = Note.fromRow(row),
//        assert(row != null),
//        super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(
//        horizontal: 1,
//        vertical: 2,
//      ),
//      child: Card(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(2),
//          side: const BorderSide(color: Colors.grey),
//        ),
//        child: ListTile(
//          title: Text(note.title),
//          subtitle: Text(note.getFormatedDate),
//          leading: Checkbox(
//            value: note.done.toBool(),
//            onChanged: (value) {
//              note.done = value.toInt();
//              if (value) note.priority = 1;
//              context.read<Notes>().update(note);
//            },
//          ),
//          trailing: IconButton(
//            icon: Icon(
//              Icons.delete,
//              color: Theme.of(context).primaryColor,
//            ),
//            onPressed: () {
//              showDialog(
//                context: context,
//                builder: (context) => AlertDialog(
//                  content: Text('Do you want to delete this note'),
//                  actions: <Widget>[
//                    FlatButton(
//                      textColor: Theme.of(context).primaryColor,
//                      child: Text('No'),
//                      onPressed: () => Navigator.pop(context),
//                    ),
//                    FlatButton(
//                      textColor: Theme.of(context).primaryColor,
//                      child: Text('Yes'),
//                      onPressed: () async {
//                        await context.read<Notes>().remove(note);
//                        Navigator.pop(context);
//                      },
//                    )
//                  ],
//                ),
//              );
//            },
//          ),
//        ),
//      ),
//    );
//  }
//}

//new note widget
class NoteWidget extends StatelessWidget {
  final Note note;

  NoteWidget(Map<String, dynamic> row, {Key key})
      : note = Note.fromRow(row),
        assert(row != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: CustomPaint(
        painter: NoteWidgetPainter(note),
        size: Size(double.infinity, 100),
      ),
    );
  }
}

const redColor = const Color(0xffFF0057);
const yellowColor = const Color(0xffFFE600);
const greenColor = const Color(0xff00FF80);

class NoteWidgetPainter extends CustomPainter {
  final Note note;
  final _circlePaint = Paint();

  final _whitePaint = Paint()..color = Colors.white;

  NoteWidgetPainter(this.note, {Listenable repaint}) : super(repaint: repaint) {
    switch (note.priority) {
      case 1:
        _circlePaint.color = greenColor;
        break;
      case 2:
        _circlePaint.color = yellowColor;
        break;
      case 3:
        _circlePaint.color = redColor;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final max = math.max<double>(size.width, size.height);

    final rrect = RRect.fromLTRBR(
      25,
      0,
      size.width,
      size.height,
      const Radius.circular(20),
    );

    canvas.drawShadow(Path()..addRRect(rrect), Colors.grey[100], 3, true);

    canvas.drawRRect(
      rrect,
      _whitePaint,
    );

    final circleCenter = Offset(25, size.height / 2);

    canvas.drawCircle(circleCenter, 25, _circlePaint);

    //Draw "!"
    {
      final tp = TextPainter(
        text: const TextSpan(
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
          text: '!',
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      //to draw the "!" at the center of the circle.
      tp.layout(minWidth: 0, maxWidth: 0);
      final position = Offset(
        circleCenter.dx,
        circleCenter.dy - (tp.height / 2),
      );

      tp.paint(canvas, position);
    }

    //Draw The title of note.
    {
      final tp = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          text: note.title,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout();
      final position = Offset(
        size.width / 2 - (tp.width / 2),
        20,
      );

      tp.paint(canvas, position);
    }

    //Draw The date of note.
    {
      final tp = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          text: note.getFormatedDate,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout();
      final position = Offset(
        30,
        50,
      );

      tp.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
