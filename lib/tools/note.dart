class Note {
  int id, priority, done;
  String title, description, reminder;

  Note({
    this.priority = 1,
    this.done = 0,
    this.title = '',
    this.description = '',
    this.reminder = '',
  });

  Note.fromRow(Map<String, dynamic> row) {
    id = row['id'];
    priority = row['priority'];
    done = row['done'];
    title = row['title'];
    description = row['description'];
    reminder = row['reminder'];
  }

  Map<String, dynamic> toRow() {
    return {
      'id': id,
      'priority': priority,
      'done': done,
      'title': title,
      'description': description,
      'reminder': reminder
    };
  }

  void copyValuesFrom(Note note) {
    id = note.id;
    priority = note.priority;
    done = note.done;
    title = note.title;
    description = note.description;
    reminder = note.reminder;
  }
}
