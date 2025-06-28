import 'package:flutter/material.dart';
import 'package:fokus/pages/stats/stats_page.dart';
import 'package:fokus/pages/tags/tags_page.dart';
import 'package:fokus/pages/timer/timer_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          /// Destinations
          NavigationDestination(
            selectedIcon: Icon(Icons.timer),
            icon: Icon(Icons.timer_outlined),
            label: 'Timer',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.label),
            icon: Icon(Icons.label_outline),
            label: 'Tags',
          ),
        ],
      ),
      body: <Widget>[
        /// Pages
        const TimerPage(),
        const StatsPage(),
        const TagsPage(),
      ][currentPageIndex],
    );
  }
}
