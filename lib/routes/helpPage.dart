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
              subtitle: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.subtitle1,
                  children: [
                    const TextSpan(
                        text:
                            'click on the note that you want to delete then click '),
                    WidgetSpan(
                      child: Icon(
                        Icons.delete_forever,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextSpan(text: ''),
                  ],
                ),
              ),

              // Row(
              //   children: <Widget>[
              //     // Icon(
              //     //   Icons.delete_forever,
              //     //   color: Theme.of(context).primaryColor,
              //     // ),
              //     // const Text('the note that you want to delete, than click'),

              //   ],
              // ),
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

          //How to share my database(All my notes) ?
          Card(
            child: ListTile(
              title: Text('How to share my notes ?'),
              subtitle: Text(
                  'Open the Setting page than click "share notes as CSV".'),
            ),
          ),

          //How to export my database(All my notes) ?
          Card(
            child: ListTile(
              title: Text('How to export my notes ?'),
              subtitle: Text('''Open the Setting page than click "export notes".
Warning ⚠️:the app need a permission to export your notes to an external file'''),
            ),
          ),

          //How to give or prevent permission ?
          Card(
            child: ListTile(
                title: Text('How to give or prevent permission ?'),
                subtitle: Text(
                    'Open the Setting page than click "Manage permissions".')),
          ),

          //How to import a database as file?
          Card(
            child: ListTile(
              title: Text('How to import notes from a file ?'),
              subtitle: Text(
                  '''Open the Setting page than click "Import notes\nthen choose a valid file".
Warning ⚠️ : your old notes will be deleted.
Warning ⚠️ : enter a valid CSV file (for more information , see "What is CSV ?").

'''),
            ),
          ),

          //How to import a database ?
          Card(
            child: ListTile(
              title: Text('How to import notes from CSV text ?'),
              subtitle: Text(
                  '''Open the Setting page than paste your CSV text in "Import notes as CSV".
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
