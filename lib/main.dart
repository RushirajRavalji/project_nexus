import 'package:flutter/material.dart';
import 'package:project_nexus/intro_page.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (fn) {
      runApp(Nexus());
    },
  );
}

class Nexus extends StatelessWidget {
  const Nexus({super.key});

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
