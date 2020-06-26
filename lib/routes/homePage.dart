import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'editNotePage.dart';
import './notePage.dart';
import './settingsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        key: _scaffold,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            bottom: const TabBar(
              tabs: [
                const Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Notes"),
                  ),
                ),
                const Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Goals"),
                  ),
                ),
                const Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text("Settings"),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NotePage(
              scaffoldKey: _scaffold,
            ),
            Icon(Icons.movie),
            SettingsPage(),
          ],
        ),
        floatingActionButton: OpenContainer(
          closedShape: const CircleBorder(),
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
