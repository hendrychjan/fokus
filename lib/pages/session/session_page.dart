import 'package:flutter/material.dart';

class SessionPage<T> extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Session"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: []),
      ),
    );
  }
}
