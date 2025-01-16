import 'package:flutter/material.dart ';
import 'package:project_nexus/intro_page.dart';

void main() {
  runApp(nexus());
}

class nexus extends StatelessWidget {
  const nexus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: IntroPage(),
        ),
      ),
    );
  }
}
