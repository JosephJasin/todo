part of pages;

class HelpPage extends StatelessWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: ListView(
        children: <Widget>[
          //How to add a new note ?
          Card(
            child: ListTile(
              title: Text('How to add a new note ?'),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    const Text('Click on the '),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                    const Text(' Button on the Home Page.'),
                  ],
                ),
              ),
            ),
          ),
          //How to edit the content of the note ?
          Card(
            child: ListTile(
              title: const Text('How to edit the content of the note ?'),
              subtitle:
                  const Text('Just click on the note that you want to edit.'),
            ),
          ),
          //How to delete a note ?
          Card(
            child: ListTile(
              title: const Text('How to delete a note ?'),
              subtitle: Row(
                children: <Widget>[
                  const Text(
                    'click on the note that you want to delete, than click ',
                  ),
                  Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          //What is CSV?
          Card(
            child: ListTile(
              title: const Text('What is CSV ?'),
              subtitle: const Text(
                  '''A Comma Separated Values (CSV) is a plain text that contains a list of data.
each line in CSV repesent a row(note) in the database.
each row have an id , priority , title , description , reminder , and are separeted with a comma ( , ).
id: must be a positive intgeral number.
priority: must be 0 (low proirity) or 1 (medium priority) or 2 (high priority).
title: anything  😁.
description: anything 😁.
reminder: an ISO 8601 date ,
example: 2020-07-31 19:16:00.000.
Note that hours are specified between 0 and 23.
'''),
            ),
          ),

          //How to export my database(All my notes) ?
          Card(
            child: ListTile(
              title: Text('How to export my database(All my notes) ?'),
              subtitle: Text(
                  '''Open the Setting page than clcik "Export the database as CSV" , click "Copy",
and now you can send the information using any method you want  😄.
'''),
            ),
          ),
          //How to import a database ?
          Card(
            child: ListTile(
              title: Text('How to import a database ?'),
              subtitle: Text(
                  '''Open the Setting page than paste your CSV text in "Import the database as CSV".
Warning ⚠️ : your old notes will be deleted.
Warning ⚠️ : enter a valid CSV text (for more information , see "What is CSV ?").

'''),
            ),
          ),
        ],
      ),
    );
  }
}
