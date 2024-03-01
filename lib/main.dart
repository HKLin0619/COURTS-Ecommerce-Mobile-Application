import 'package:flutter/material.dart';
import 'startPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Screens',
      initialRoute: '/',
      routes: {
        '/': (context) => const startPage(),
      },
    );
  }
}

