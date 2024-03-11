import 'package:flutter/material.dart';
import 'startPage.dart';
import 'loginPage.dart';
import 'createAccountPage.dart';
import 'adminPage.dart';
import 'addFurniture.dart';

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
      initialRoute: '/login',
      routes: {
        '/': (context) => const startPage(),
        '/login': (context) => const loginPage(),
        '/signUp': (context) => const createAccountPage(),
        '/admin': (context) => const adminPage(),
        '/addFurniture': (context) => const addFurniturePage(),
      },
    );
  }
}

