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
          itemExtent: 150,
          itemBuilder: (context, index) {
            final row = builder.notes[index];
            return Dismissible(
              key: ValueKey<int>(index),
              background: ColoredBox(
                color: Colors.red,
              ),
              direction: DismissDirection.startToEnd,
              dismissThresholds: const {
                DismissDirection.startToEnd:0.5
              },

              onDismissed: (dismissDirection){
                builder.remove(Note.fromRow(row));
              },

              child: OpenContainer(
                closedElevation: 0,
                openElevation: 0,
                closedBuilder: (context, action) => NoteWidget(
                  row,
                ),
                openBuilder: (context, action) => EditNotePage(
                  row: row,
                  scaffold: scaffoldKey,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

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

//[redColor] for max prioriy (3)
//[yelloColor] for intermediate prioriy (2)
//[greeColor] for trivial priority (1)
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
    const diameter = 25.0;

    final rrect = RRect.fromLTRBR(
      diameter,
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

    final circleCenter = Offset(diameter, size.height / 2);

    canvas.drawCircle(circleCenter, diameter, _circlePaint);

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
        maxLines: 1,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          text: note.title,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout(maxWidth: size.width / 1.5);
      final position = Offset(
        size.width / 2 - (tp.width / 2),
        circleCenter.dy - (tp.height / 2),
      );

      tp.paint(canvas, position);
    }

    //Draw The date of note.
    {
      final tp = TextPainter(
        maxLines: 1,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          text: note.getFormatedDate,
        ),
        textDirection: TextDirection.ltr,
      );

      tp.layout(maxWidth: size.width / 1.5);
      final position = Offset(
        35,
        size.height - (tp.height),
      );

      tp.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
