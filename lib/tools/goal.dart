class Goal {
  int id, priority;
  String title, description, tasks, startDate, endDate, reminder;

  Goal(
      {this.priority = 1,
      this.title = '',
      this.description = '',
      this.tasks = '',
      this.startDate = '',
      this.endDate = '',
      this.reminder = ''});

  Goal.fromRow(Map<String, dynamic> row) {
    id = row['id'];
    priority = row['priority'];
    title = row['title'];
    description = row['description'];
    tasks = row['tasks'];
    startDate = row['startDate'];
    endDate = row['endDate'];
    reminder = row['reminder'];
  }

  Map<String, dynamic> toRow() {
    return {
      'id': id,
      'priority': priority,
      'title': title,
      'description': description,
      'tasks': tasks,
      'startDate': startDate,
      'endDate': endDate,
      'reminder': reminder
    };
  }
}
