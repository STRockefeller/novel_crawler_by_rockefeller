import 'package:flutter/material.dart';

import 'View/MyHomePage.dart';
//import 'View/ScraperExample.dart';

void main() {
  runApp(MyApp());
  //runApp(WebScraperApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

