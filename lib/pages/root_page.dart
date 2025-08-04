import 'package:flutter/material.dart';
import 'package:fokus/pages/history/history_page.dart';
import 'package:fokus/pages/session/session_page.dart';
import 'package:fokus/pages/stats/stats_page.dart';
import 'package:fokus/pages/tags/tags_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          /// Destinations
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: "Stats",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.fast_rewind),
            icon: Icon(Icons.fast_rewind_outlined),
            label: "History",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.timer),
            icon: Icon(Icons.timer_outlined),
            label: "Session",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sell),
            icon: Icon(Icons.sell_outlined),
            label: "Tags",
          ),
        ],
      ),
      body: <Widget>[
        /// Pages
        const StatsPage(),
        HistoryPage(),
        const SessionPage(),
        TagsPage(),
      ][currentPageIndex],
    );
  }
}
