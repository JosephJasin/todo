import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'editPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            bottom: TabBar(tabs: [
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
            ]),
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.apps),
            Icon(Icons.movie),
          ],
        ),
        floatingActionButton: OpenContainer(
          closedShape: const CircleBorder(),
          closedColor: Colors.red,
          closedBuilder: (context, action) => const FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          ),
          openBuilder: (context, action) => EditPage(),
          transitionType: ContainerTransitionType.fade,
          transitionDuration: const Duration(milliseconds: 350),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
