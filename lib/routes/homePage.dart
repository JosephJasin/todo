import 'package:NotesAndGoals/routes/NotePage.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'editNotePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffold,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Notes"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Goals"),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NotePage(),
            Icon(Icons.movie),
          ],
        ),
        floatingActionButton: OpenContainer(
          closedShape: const CircleBorder(),
          //closedColor: Colors.red,

          closedBuilder: (context, action) {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            );
          },
          openBuilder: (context, action) => EditNotePage(
            scaffold: _scaffold,
          ),
          transitionType: ContainerTransitionType.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
