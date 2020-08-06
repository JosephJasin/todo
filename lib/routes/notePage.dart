part of pages;

class NotePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  NotePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, Notes builder, child) {
        if (builder.notesLength == 0) {
          return Center(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.subtitle1,
                children: [
                  TextSpan(text: 'Click on '),
                  WidgetSpan(
                      child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(Icons.add, size: 20),
                  )),
                  TextSpan(text: ' to add a new note'),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: builder.notesLength,
          itemExtent: 110,
          itemBuilder: (context, index) {
            final row = builder.notes[index];
            return OpenContainer(
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => NoteWidget(
                row,
              ),
              openBuilder: (context, action) => EditNotePage(
                row: row,
                scaffold: scaffoldKey,
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
        painter: NoteWidgetPainter(note, titleFontSize: 15, dateFontSize: 10),
        size: Size(double.infinity, 100),
      ),
    );
  }
}

class NoteWidgetPainter extends CustomPainter {
  final Note note;
  final _circlePaint = Paint();

  final _whitePaint = Paint()..color = Colors.white;

  final double titleFontSize;
  final double dateFontSize;

  NoteWidgetPainter(this.note,
      {Listenable repaint, this.titleFontSize = 25, this.dateFontSize = 20})
      : super(repaint: repaint) {
    switch (note.priority) {
      case 0:
        _circlePaint.color = greenColor;
        break;
      case 1:
        _circlePaint.color = yellowColor;
        break;
      default:
        _circlePaint.color = redColor;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final diameter = titleFontSize;

    final rrect = RRect.fromLTRBR(
      diameter,
      0,
      size.width,
      size.height,
      const Radius.circular(20),
    );

    canvas.drawShadow(Path()..addRRect(rrect), _circlePaint.color, 2.5, true);

    canvas.drawRRect(
      rrect,
      _whitePaint,
    );

    final circleCenter = Offset(diameter, size.height / 2);

    canvas.drawCircle(circleCenter, diameter, _circlePaint);
    if (note.priority == 2) {
      const icon = Icons.whatshot;
      final builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontFamily: icon.fontFamily, fontSize: diameter),
      )..addText(String.fromCharCode(icon.codePoint));

      final para = builder.build();

      para.layout(const ui.ParagraphConstraints(width: 0));
      canvas.drawParagraph(
          para,
          Offset(
            circleCenter.dx - (para.height / 2),
            circleCenter.dy - (para.height / 2),
          ));
    }

    //Draw "!"
    else if (note.priority == 1) {
      final tp = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: diameter * 1.5,
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
    } else {
      const icon = Icons.spa;
      final builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontFamily: icon.fontFamily, fontSize: diameter),
      )..addText(String.fromCharCode(icon.codePoint));

      final para = builder.build();

      para.layout(const ui.ParagraphConstraints(width: 0));
      canvas.drawParagraph(
          para,
          Offset(
            circleCenter.dx - (para.height / 2),
            circleCenter.dy - (para.height / 2),
          ));
    }

    //Draw The title of note.
    {
      final tp = TextPainter(
        maxLines: 1,
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFontSize,
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
          style: TextStyle(
            color: Colors.grey,
            fontSize: dateFontSize,
          ),
          text: note.getFormatedDate,
        ),
        textDirection: TextDirection.ltr,
      );

      tp.layout(maxWidth: size.width / 1.5);
      final position = Offset(
        40,
        size.height - (tp.height) - 5,
      );

      tp.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(NoteWidgetPainter old) {
    return old.note != note;
  }
}
